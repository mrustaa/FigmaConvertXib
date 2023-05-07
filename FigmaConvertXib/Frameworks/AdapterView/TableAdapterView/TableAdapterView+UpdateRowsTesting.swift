//
//  TableAdapterView+UpdateRowsTesting.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 05.06.2021.
//

import Foundation

extension TableAdapterView {
  
  static var testChangeItems: [TableAdapterItem] = []
  
  // MARK: - Set Rows Print Debug
  
  public func testSet(rows items: [TableAdapterItem]) {
    
    let newItems = items
    let oldItems = self.items
    
    print(" --------------------------------------------------- ")
    print(" Table Old 💎 count: \(oldItems.count) ")
    for it in oldItems {
      print(it.cellData?.dataStr() ?? "")
    }
    print(" --------------------------------------------------- ")
    print(" Table New 🧩 count: \(newItems.count)")
    for it in newItems {
      print(it.cellData?.dataStr() ?? "")
    }
    
    let rows = setFull(rows: items)
    
    print(" --------------------------------------------------- ")
    print(" Table Rows 🟢 Add    count: \(rows.insert.count)")
    for i in rows.insert {
      print("\(i.row)")
    }
    print(" --------------------------------------------------- ")
    print(" Table Rows 🔴 Delete count: \(rows.delete.count)")
    for i in rows.delete {
      print("\(i.row)")
    }
  }
  
  // MARK: Init
  
//  public func testInit() {
//
//    if !self.items.isEmpty {
//      main(delay: 0.1) { [weak self] in
//        self?.testChangeRowsAnimation()
//      }
//    }
//  }
  
///   MARK: - Timer Repeats
  
//  public func testChangeRowsAnimationTimer(timer: Double) {
//    _ = Timer.scheduledTimer(timeInterval: timer, target: self, selector: #selector(testChangeRowsAnimation), userInfo: nil, repeats: true)
//  }
  
  /// MARK: Testing
//
//  @objc public func testChangeRowsAnimation() {
//
//    var itms: [TableAdapterItem] = []
//
//// MARK: Create Item
//
//    func createItem(_ index: Int, _ section: Int) -> ProductsItem {
//      return ProductsItem(
//        state: .init(sum: "14531 Р", title: "VISA Индекс \(index)", subtitle: "Секция \(section)", card: "179251852".accountFormatted.masked(), size: .big),
//        index: index
//      )
//    }
//
/// MARK: Create Section
//
//    func createSection(_ section: Int) -> ProductsSectionItem {
//      return ProductsSectionItem(
//        title: "Секция \(section)", index: section,
//        presetingType: .close,
//        changePreseting: { [weak self] type, index in
//          self?.testChangeRowsAnimation()
//        }
//      )
//    }
//
//    let testChangeItems = TableAdapterView.testChangeItems
//    if !testChangeItems.isEmpty {
//
//      let all = Int.random(in: 0..<2)
//
//      if all != 2 {
//        itms += TableAdapterView.testChangeItems
//      } else {
//        TableAdapterView.testChangeItems = []
//      }
//
//      switch all {
//
///      case 0: // MARK: Remove
//
//        let count = itms.count
//        for ii in 0..<count {
//          if ii < itms.count {
//            let item = itms[ii]
//            if item is ProductsSectionItem, ii == 0 {
//            } else {
//              let delete = Int.random(in: 0..<2)
//              if delete == 0 {
//                itms.remove(at: ii)
//              }
//            }
//          }
//        }
//
//        TableAdapterView.testChangeItems = itms
//        testSet(rows: itms)
//        return
//
///      case 1: // MARK: Insert
//
//        let count = Int.random(in: 0..<10)
//        for yy in 0..<count {
//          let add = Int.random(in: 0..<2)
//          if add == 0 {
//            let s = Int.random(in: 0..<15)
//            let sect = Int.random(in: 0..<4)
//            let item = ((sect == 0) ? createSection(s) : createItem(yy,s) )
//            let findIndex = item.search(toArray: itms)
//            if findIndex == nil {
//              itms.append(item)
//            }
//          }
//        }
//
//        TableAdapterView.testChangeItems = itms
//        testSet(rows: itms)
//        return
//
//      default: break
//      }
//    }
//
///    // MARK: Add All
//
//    let sections = Int.random(in: 1..<3)
//
//    func createItems(_ rand: Int, _ section: Int) -> [TableAdapterItem] {
//      var prs: [TableAdapterItem] = []
//      for i in 0..<rand {
//        prs.append(
//          createItem(i,section)
//        )
//      }
//      return prs
//    }
//
//    for s in 0..<sections {
//      itms.append(
//        createSection(s)
//      )
//
//      let r1 = Int.random(in: 2..<10)
//      itms += createItems(r1, s)
//    }
//
//
//    TableAdapterView.testChangeItems = itms
//    testSet(rows: itms)
//  }
}

