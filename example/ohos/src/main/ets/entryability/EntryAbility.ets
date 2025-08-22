/**
 * Entry point for HarmonyOS Next Flutter app with Stockfish
 * This demonstrates how to use the Stockfish plugin on HarmonyOS
 */

import AbilityConstant from '@ohos.app.ability.AbilityConstant'
import hilog from '@ohos.hilog'
import UIAbility from '@ohos.app.ability.UIAbility'
import Want from '@ohos.app.ability.Want'
import window from '@ohos.window'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'stockfish_example', '%{public}s', 'Ability onCreate')
  }

  onDestroy(): void {
    hilog.info(0x0000, 'stockfish_example', '%{public}s', 'Ability onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    hilog.info(0x0000, 'stockfish_example', '%{public}s', 'Ability onWindowStageCreate')
    
    // Main window for Flutter app
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'stockfish_example', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err))
        return
      }
      hilog.info(0x0000, 'stockfish_example', 'Succeeded in loading the content.')
    })
  }

  onWindowStageDestroy(): void {
    hilog.info(0x0000, 'stockfish_example', '%{public}s', 'Ability onWindowStageDestroy')
  }

  onForeground(): void {
    hilog.info(0x0000, 'stockfish_example', '%{public}s', 'Ability onForeground')
  }

  onBackground(): void {
    hilog.info(0x0000, 'stockfish_example', '%{public}s', 'Ability onBackground')
  }
}