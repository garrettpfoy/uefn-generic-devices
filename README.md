
## Device Reference

### ui/ui_device
This device was made to act as a UI manager for an entire map. Generally, this device provides methods of adding canvas slots to a root UI widget, which allows for plugin-like abstractions for additional devices. Additionally, this device ensures that all slots have a central location and source of truth so adding/removing widgets should be much easier than implementation in each device you want UI functionality in.

#### Initialization
This device has no dependencies and can be placed within your world without any existing setup.

#### Scope
Global, needs to be enabled throughout the creative map round (or while you are requiring UI functionality)

#### Functionality

| Method | Parameters     | Description                |
| :-------- | :------- | :------------------------- |
| `AddSlot` | `CanvasSlot` **:** `canvas_slot` | Appends a supplied canvas_slot object to the current UI for **every** player |
| `AddSlot` | `CanvasSlot` **:** `canvas_slot` **,** `Player` **:** `player` | Appends a supplied canvas_slot object to the current UI for a **target** player |
| `AddSlots` | `CanvasSlots` **:** `[]canvas_slot` | Appends a supplied canvas_slot array to the current UI for **every** player |
| `AddSlots` | `CanvasSlots` **:** `[]canvas_slot` **,** `Player` **:** `player` | Appends a supplied canvas_slot array to the current UI for a **target** player |
| `RemoveSlot` | `CanvasSlot` **:** `canvas_slot` | Removes a supplied canvas_slot object from the UI for **every** player |
| `RemoveSlot` | `CanvasSlot` **:** `canvas_slot` **,** `Player` **:** `player` | Removes a supplied canvas_slot object from the UI for a **target** player |
| `RemoveSlots` | `CanvasSlots` **:** `[]canvas_slot` | Removes a supplied canvas_slot array from the UI for **every** player |
| `RemoveSlots` | `CanvasSlots` **:** `[]canvas_slot` **,** `Player` **:** `player` | Removes a supplied canvas_slot arrayfrom the UI for a **target** player |

#### Examples
##### Linking:
```verse
@editable
UIDevice : ui_device = ui_device{}
```

##### Adding a simple text_block widget to all players, then remove it after 5 seconds:
```verse
StringToMessage<localizes>(String : string) : message = "{String}"

NotificationSlot : canvas_slot = canvas_slot:
    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
    Alignment := vector2{X := 0.5, Y := 0.5}
    SizeToContent := true
    Widget := text_block{ DefaultText := StringToMessage("Notification!") }

UIDevice.AddSlot(NotificationSlot)

Sleep(5.0)

UIDevice.RemoveSlot(NotificationSlot)
```

##### Adding a canvas object to a specific player
**Note:** *Example may use variable declarations from previous (above) examples*
```verse
## Note: Assuming an Agent object is somewhere within this scope

Canvas : canvas = canvas:
    Slots := array{NotificationSlot, NotificationSlot, NotificationSlot}

if(Player := player[Agent]):
    UIDevice.AddSlots(Canvas.Slots, Player)
```

#### Best Practices:
* Each UI "plug-in" (another device that contributes to the UI), should keep track of the slots they add themselves. The ui_device is a "wrapper" in a sense to the built-in player_ui method and doesn't keep track of which device contributes which ui widgets.


