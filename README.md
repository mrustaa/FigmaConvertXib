![image(Landscape)](https://github.com/mrustaa/gif_presentation/blob/master/FigmaConvert/figmaConvertLogo4.png)

# FigmaConvertXib/Xml

FigmaConvertXib is a tool for exporting design elements from [Figma](http://figma.com/) and generating `Xib` / `Xml` file to a `iOS` and `Android` projects.

## Preview
![image(Landscape)](https://github.com/mrustaa/gif_presentation/blob/master/FigmaConvert/gifPS2.gif)

#### Watch the video 
[▶️ Add Figma Projects](https://youtu.be/2Cue6R7TfjA) 

[▶️ Page Types](https://youtu.be/2Cue6R7TfjA)

#### Table of context
- [Installation](#installation)
    - [Base parameters](#base-parameters)
    - [Figma access token](#figma-access-token)

Currently, FigmaConvertXib supports the following entities:

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

#### Fill
- ✅ 
  - Solid
  - Images
  - Gradient Linear
  - Gradient Radial
- ❌ 
  - Gradient Angular
  - Gradient Diamond

#### Effect
- ✅ (Only in iOS)
  - Inner Shadow
  - Drop  Shadow
  - Layer Blur


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
