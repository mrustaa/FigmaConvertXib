![image(Landscape)](https://github.com/mrustaa/gif_presentation/blob/master/FigmaConvert/figmaConvertLogo4.png)

# FigmaConvertXib/Xml

FigmaConvertXib is a tool for exporting design elements from [Figma](http://figma.com/) and generating file to a projects

`.Xib iOS Xcode` / `.Xml Android-Studio` .

- [Watch video with examples](#watch-video-with-examples)
- [Installation](#installation)
  - [Base parameters](#base-parameters)
  - [Figma access token](#figma-access-token)
  - [Add Figma project id](#add-figma-project-id)
- [Complection Generation Xib Xml to projects Xcode Android](#complection-generation-xib-xml-to-projects-xcode-android)
- [Currently supports the following entities](#currently-supports-the-following-entities)
- [Export vector icons](#export-vector-icons)
- [Author](#author)
- [License](#license)

## Preview
![image(Landscape)](https://github.com/mrustaa/gif_presentation/blob/master/FigmaConvert/gifPS2.gif)

## Watch video with examples
[▶️ Add Figma Projects](https://youtu.be/2Cue6R7TfjA) 

[▶️ Page Types](https://youtu.be/UAX1FXRFouw)

## Installation:

### Base parameters
Each step of generation is using the following base parameters:
- `accessToken`: an access token string that is needed to execute Figma API requests (see [Figma access token](#figma-access-token)).
- `project id`: URL of a Figma file, which data will be used to generate code (see [Figma file](#figma-file)).

### Figma access token
Authorization is required to receive Figma files.
The authorization is implemented by transferring a personal access token.
This token could be created in a few simple steps:
1. Open [account settings]((https://www.figma.com/settings)) in Figma.
2. Press "Create a new personal access token" button in the "Personal Access Tokens" section.
3. Enter a description for the token (for instance, "FigmaConvertXib").
4. Copy the created token to the clipboard.

![](https://github.com/mrustaa/gif_presentation/blob/master/FigmaConvert/AccessToken.png)

Then `Compile / Run` the project `FigmaConvertXib.xcodeproj` and paste the received access Token in the accessToken field. It is enough to define it only in the base section if this token allows access to all Figma files, which appear in the configuration.


### Add Figma project id
Open the URL figma project, and copy its project-id 
Then open the application, click button-plus, and paste the received project-id 

![](https://github.com/mrustaa/gif_presentation/blob/master/FigmaConvert/ProjectId.png)

## Complection Generation Xib Xml to projects Xcode Android

#### Xcode 
- Open project `FigmaConvertXib.xcodeproj`
- And go to folder `/ Figma / Xib / result_ios.xib`

#### Android-Studio 
- Open project `FigmaConvertAndroidXml`
- And go to folder `/ app / res / layout / result_android.xml`

![image(Landscape)](https://github.com/mrustaa/gif_presentation/blob/master/FigmaConvert/gifPS3.gif)

## Currently supports the following entities:

#### Nodes
- ✅ iOS (View / Layer) | Android (ConstraintLayout) 
  - Rectangle
  - Frame
  - Page
  - Group 
- ✅ iOS | Android (ImageView)
  - Image Fill
  - Component
- ✅ iOS (Label) | Android (TextView)
  - Text
- ✅ Vector 
  - Ellipse 
  - Polygone 
  - Star
- ❌ Vector 
  - Line
  - Line Arrow
  - Curves
#### Fills
- ✅ Solid
  - Images
  - Gradient Linear
  - Gradient Radial
- ❌ Gradient Angular
  - Gradient Diamond
#### Effects
- ✅ (Only in iOS)
  - Shadow Inner 
  - Shadow Drop  
  - Blur Layer 
- ❌ Blur Background 

## Export vector icons

In order to export vector-icons in Figma, уou need to select `vector layers` and click `create component`.

Will begin downloading images. 
- `/ Figma / Xib / images.xcassets` 
- `/ app / res / drawable `

In .xib .xml it will be generated into an ImageView

![image(Landscape)](https://github.com/mrustaa/gif_presentation/blob/master/FigmaConvert/vectorIconExport.gif)

## Author

<motionrustam@gmail.com> 📩| [mrustaa](https://github.com/mrustaa/)

## License

FigmaConvertXib is available under the MIT license. See the LICENSE file for more info.

