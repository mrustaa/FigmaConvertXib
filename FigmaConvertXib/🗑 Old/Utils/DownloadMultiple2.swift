//
//  DownloadMultiple2.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 11.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation
import UIKit


class DownloadManager: NSObject {
    
    fileprivate var operations = [Int: DownloadOperation]()
    
    private let queue: OperationQueue = {
           let _queue = OperationQueue()
               _queue.name = "download"
               _queue.maxConcurrentOperationCount = 1
        return _queue
    }()
    
    lazy var session: URLSession = {
                                     let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    // var callback: (([UIImage]) -> ())? = nil
    
    var result: [Data] = []
    
    @discardableResult
    func queueDownload(_ url: URL) -> DownloadOperation {
        let operation = DownloadOperation(session: session, url: url)
        operations[operation.task.taskIdentifier] = operation
        queue.addOperation(operation)
        
        operation.callback = { [weak self] data, url in
            guard let _self = self else { return }
            
            _self.result.append( data )
        }
        
        return operation
    }
    
    func cancelAll() {
        queue.cancelAllOperations()
    }

}

// MARK: URLSessionDownloadDelegate methods

extension DownloadManager: URLSessionDownloadDelegate {

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        operations[downloadTask.taskIdentifier]?.urlSession(session, downloadTask: downloadTask, didFinishDownloadingTo: location)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        operations[downloadTask.taskIdentifier]?.urlSession(session, downloadTask: downloadTask, didWriteData: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
    }
}

// MARK: URLSessionTaskDelegate methods

extension DownloadManager: URLSessionTaskDelegate {

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)  {
        let key = task.taskIdentifier
        operations[key]?.urlSession(session, task: task, didCompleteWithError: error)
        operations.removeValue(forKey: key)
    }

}

// MARK: - 🐥 AsynchronousOperation

class AsynchronousOperation: Operation {
    
    @objc private enum OperationState: Int {
        case ready
        case executing
        case finished
    }
    
    var callback: ((Data, URL) -> ())? = nil
    
    private let stateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".rw.state", attributes: .concurrent)
    
    private var rawState: OperationState = .ready
    
    @objc private dynamic var state: OperationState {
        get { return stateQueue.sync { rawState } }
        set { stateQueue.sync(flags: .barrier) { rawState = newValue } }
    }
    
    // MARK: - Various `Operation` properties
    
    open         override var isReady:        Bool { return state == .ready && super.isReady }
    public final override var isExecuting:    Bool { return state == .executing }
    public final override var isFinished:     Bool { return state == .finished }
    
    open override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        if ["isReady", "isFinished", "isExecuting"].contains(key) {
            return [#keyPath(state)]
        }

        return super.keyPathsForValuesAffectingValue(forKey: key)
    }
    
    public final override func start() {
        if isCancelled {
            finish()
            return
        }

        state = .executing

        main()
    }
    
    open override func main() {
        fatalError("Subclasses must implement `main`.")
    }

    public final func finish() {
        if !isFinished {
            state = .finished
        }
    }
}

// MARK: - 🐥 DownloadOperation

class DownloadOperation : AsynchronousOperation {
    let task: URLSessionTask

    init(session: URLSession, url: URL) {
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = ["X-Figma-Token" : LocalData.current.token ?? ""]
        
        task = session.downloadTask(with: request)
        
//        task = session.downloadTask(with: url)
        super.init()
    }

    override func cancel() {
        task.cancel()
        super.cancel()
    }

    override func main() {
        task.resume()
    }
}

// MARK: NSURLSessionDownloadDelegate methods

var images: [UIImage] = []

extension DownloadOperation: URLSessionDownloadDelegate {

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard
            let httpResponse = downloadTask.response as? HTTPURLResponse,
            200..<300 ~= httpResponse.statusCode
        else {
            // handle invalid return codes however you'd like
            return
        }
        
        do {
            let manager = FileManager.default
            let destinationURL = try manager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(downloadTask.originalRequest!.url!.lastPathComponent)
            try? manager.removeItem(at: destinationURL)
            try manager.moveItem(at: location, to: destinationURL)
            
            
            //print(destinationURL)
            
            let imageData = try? Data(contentsOf: destinationURL)
            
            if let data = imageData {
                
                if let url = downloadTask.originalRequest?.url { //.absoluteString
                    callback?(data, url)
                }
//                if let image = UIImage(data: data) {
//                    images.append( image )
//                }
            }
            
            
            
        } catch {
            print(error)
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        print("\(downloadTask.originalRequest!.url!.absoluteString) \(progress)")
    }
}

// MARK: URLSessionTaskDelegate methods

extension DownloadOperation: URLSessionTaskDelegate {

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)  {
        defer { finish() }

        if let error = error {
            print(error)
            return
        }

        // do whatever you want upon success
    }

}


//let downloadManager = DownloadManager()
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    let urlStrings = [
//        "http://spaceflight.nasa.gov/gallery/images/apollo/apollo17/hires/s72-55482.jpg",
//        "http://spaceflight.nasa.gov/gallery/images/apollo/apollo10/hires/as10-34-5162.jpg",
//        "http://spaceflight.nasa.gov/gallery/images/apollo-soyuz/apollo-soyuz/hires/s75-33375.jpg",
//        "http://spaceflight.nasa.gov/gallery/images/apollo/apollo17/hires/as17-134-20380.jpg",
//        "http://spaceflight.nasa.gov/gallery/images/apollo/apollo17/hires/as17-140-21497.jpg",
//        "http://spaceflight.nasa.gov/gallery/images/apollo/apollo17/hires/as17-148-22727.jpg"
//    ]
//    let urls = urlStrings.compactMap { URL(string: $0) }
//
//    let completion = BlockOperation {
//        print("all done")
//    }
//
//    for url in urls {
//        let operation = downloadManager.queueDownload(url)
//        completion.addDependency(operation)
//    }
//
//    OperationQueue.main.addOperation(completion)
//}
