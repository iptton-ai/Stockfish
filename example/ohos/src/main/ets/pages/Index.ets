/**
 * Example page showing Flutter integration with Stockfish on HarmonyOS
 */

@Entry
@Component
struct Index {
  @State message: string = 'Stockfish Flutter Example for HarmonyOS Next'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 20 })

        Text('This example demonstrates the Flutter Stockfish plugin running on HarmonyOS Next.')
          .fontSize(14)
          .margin({ bottom: 10 })
          .textAlign(TextAlign.Center)

        Text('The actual Flutter UI and Stockfish engine integration is handled by the Flutter framework.')
          .fontSize(12)
          .margin({ bottom: 20 })
          .textAlign(TextAlign.Center)

        Button('Launch Flutter App')
          .onClick(() => {
            // Flutter integration would be handled here
            console.log('Launching Flutter app with Stockfish support')
          })
          .width(200)
          .height(40)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .padding(20)
    }
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}