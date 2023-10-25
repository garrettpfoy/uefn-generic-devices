using { /Fortnite.com/Devices }
Using { /Fortnite.com/UI }

using { /Verse.org/Simulation }

using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }

ui_device := class(creative_device):

    ## Map that acts as each player's root widget
    ## This class/device is meant to handle the addition
    ## and removal of widgets to this root widget (canvas)
    PlayerCanvases : [player]?canvas = map{}

    ## Helper function that returns an empty canvas object
    ## with no canvas_slots
    GenerateCanvas() : canvas =
        BlankCanvas : canvas = canvas:
            Slots := array{}
        
        return BlankCanvas

    ## Helper function that returns a canvas with nested
    ## []canvas_slots based on given parameter
    GenerateCanvas(CanvasSlots : []canvas_slot) : canvas =
        Canvas : canvas = canvas:
            Slots := CanvasSlots

        return Canvas

    OnBegin<override>()<suspends> : void =
        if(Players := GetPlayspace().GetPlayers()):
            for(Player := Players):
                ## Fetch current player's UI, set it to a blank canvas
                ## and add to our map-tracking
                if(PlayerUI := GetPlayerUI[Player]): 
                    Canvas := GenerateCanvas()

                    PlayerUI.AddWidget(Canvas)

                    if(set PlayerCanvases[Player] = Canvas):

    ## Function that handles adding a canvas_slot to all
    ## players playing
    AddSlot(CanvasSlot : canvas_slot) : void =
        ## Iterate through all Players [Key] and their Canvas [Value]
        for(Key -> Value := PlayerCanvases):
            ## Cast/Check that Value is a Canvas
            if(Canvas := canvas[Value]):
                ## Fetch current Player UI
                if(PlayerUI := GetPlayerUI[Key]):
                    ## Store current Slots
                    var CurrentSlots : []canvas_slot = Canvas.Slots
                    
                    ## Add CanvasSlot from parameter to CurrentSlots (desired canvas_slot array)
                    set CurrentSlots = CurrentSlots + array{CanvasSlot}

                    ## Generate new Canvas with desired slots
                    NewCanvas : canvas = GenerateCanvas(CurrentSlots)

                    ## Set current UI for Player
                    PlayerUI.RemoveWidget(Canvas) ## Remove old
                    PlayerUI.AddWidget(NewCanvas) ## Add new

                    ## Set map to latest UI
                    if(set PlayerCanvases[Player] = NewCanvas):

    ## Function that handles adding a canvas_slot to a single
    ## player playing
    AddSlot(CanvasSlot : canvas_slot, Player : player) : void =
        ## Iterate through all Players [Key] and their Canvas [Value]
        for(Key -> Value := PlayerCanvases):
            ## Check if current iteration is the player we want to mutate
            if(Key = Player):
                ## Cast/check that Value is a canvas
                if(Canvas := canvas[Value]):
                    ## Fetch player UI
                    if(PlayerUI := GetPlayerUI[Key]):
                        ## Store current Slots
                        var CurrentSlots : []canvas_slot = Canvas.Slots
                        
                        ## Add CanvasSlot from parameter to CurrentSlots (desired canvas_slot array)
                        set CurrentSlots = CurrentSlots + array{CanvasSlot}

                        ## Generate new Canvas with desired slots
                        NewCanvas : canvas = GenerateCanvas(CurrentSlots)

                        ## Set current UI for Player
                        PlayerUI.RemoveWidget(Canvas) ## Remove old
                        PlayerUI.AddWidget(NewCanvas) ## Add new

                        ## Set map to latest UI
                        if(set PlayerCanvases[Player] = NewCanvas):

    ## Function that handles adding an array of canvas_slots to all
    ## players playing
    AddSlots(CanvasSlots : []canvas_slot) : void =
        ## Iterate through all Players [Key] and their Canvas [Value]
        for(Key -> Value := PlayerCanvases):
            ## Cast/check that Value is a Canvas
            if(Canvas := canvas[Value]):
                ## Fetch current UI
                if(PlayerUI := GetPlayerUI[Key]):
                    ## Store current Slots
                    var CurrentSlots : []canvas_slot = Canvas.Slots
                    
                    ## Add CanvasSlots from parameter to CurrentSlots (desired canvas_slot array)
                    set CurrentSlots = CurrentSlots + CanvasSlots 

                    ## Generate new Canvas with desired slots
                    NewCanvas : canvas = GenerateCanvas(CurrentSlots)

                    ## Set current UI for Player
                    PlayerUI.RemoveWidget(Canvas) ## Remove old
                    PlayerUI.AddWidget(NewCanvas) ## Add new

                    ## Set map to latest UI
                    if(set PlayerCanvases[Player] = NewCanvas):

    
    ## Function that handles adding an array of canvas_slots to a
    ## single player playing
    AddSlots(CanvasSlots : []canvas_slot, Player : player) : void =
        ## Iterate through all Players [Key] and their Canvas [Value]
        for(Key -> Value := PlayerCanvases):
            ## Check if current iteration is the target player
            if(Key = Player):
                ## Cast/check Value is of type Canvas
                if(Canvas := canvas[Value]):
                    ## Fetch the current UI of Player
                    if(PlayerUI := GetPlayerUI[Key]):
                        ## Store current Slots
                        var CurrentSlots : []canvas_slot = Canvas.Slots
                        
                        ## Add CanvasSlots from parameter to CurrentSlots (desired canvas_slot array)
                        set CurrentSlots = CurrentSlots + CanvasSlots 

                        ## Generate new Canvas with desired slots
                        NewCanvas : canvas = GenerateCanvas(CurrentSlots)

                        ## Set current UI for Player
                        PlayerUI.RemoveWidget(Canvas) ## Remove old
                        PlayerUI.AddWidget(NewCanvas) ## Add new

                        ## Set map to latest UI
                        if(set PlayerCanvases[Player] = NewCanvas):

    ## Function that handles removing a canvas_slot from all
    ## players playing
    RemoveSlot(CanvasSlot : canvas_slot) : void =
        ## Iterate through all Players [Key] and their Canvas [Value]
        for(Key -> Value := PlayerCanvases):
            ## Check if Value is of type Canvas
            if(Canvas := canvas[Value]):
                ## Get iteration's current UI
                if(PlayerUI := GetPlayerUI[Key]):
                    ## Initialize empty array to store wanted
                    ## canvas slots
                    var WantedSlots : []canvas_slot = array{}
                    
                    ## Iterate current CanvasSlots, if the CanvasSlot does not match the parameter
                    ## then keep it (add it to WantedSlots)
                    for(CurrentCanvasSlot : Canvas.Slots):
                        if(CurrentCanvasSlot.Widget <> CanvasSlot.Widget):
                            set WantedSlots = WantedSlots + array{CurrentCanvasSlot}

                    ## Generate new Canvas with wanted slots
                    NewCanvas : canvas = GenerateCanvas(WantedSlots)

                    ## Set current UI for Player
                    PlayerUI.RemoveWidget(Canvas)
                    PlayerUI.AddWidget(NewCanvas)

                    ## Set map to latest UI
                    if(set PlayerCanvases[Player] = NewCanvas):

    ## Function that handles adding a canvas_slot to a single
    ## player playing
    RemoveSlot(CanvasSlot : canvas_slot, Player : player) : void =
        ## Iterate through all Players [Key] and their Canvas [Value]
        for(Key -> Value := PlayerCanvases):
            ## Check if current player is target
            if(Key = Player):
                ## Cast Value as a Canvas type
                if(Canvas := canvas[Value]):
                    ## Fetch Player's current UI
                    if(PlayerUI := GetPlayerUI[Key]):
                        ## Initialize empty array to store wanted
                        ## canvas slots
                        var WantedSlots : []canvas_slot = array{}
                        
                        ## Iterate current CanvasSlots, if the CanvasSlot does not match the parameter
                        ## then keep it (add it to WantedSlots)
                        for(CurrentCanvasSlot : Canvas.Slots):
                            if(CurrentCanvasSlot.Widget <> CanvasSlot.Widget):
                                set WantedSlots = WantedSlots + array{CurrentCanvasSlot}

                        ## Generate new Canvas with wanted slots
                        NewCanvas : canvas = GenerateCanvas(WantedSlots)

                        ## Set current UI for Player
                        PlayerUI.RemoveWidget(Canvas)
                        PlayerUI.AddWidget(NewCanvas)

                        ## Set map to latest UI
                        if(set PlayerCanvases[Player] = NewCanvas):

    ## Function that handles adding an array of canvas_slots to all
    ## players playing
    RemoveSlots(CanvasSlots : []canvas_slot) : void =
        ## Iterate through all Players [Key] and their Canvas [Value]
        for(Key -> Value := PlayerCanvases):
            ## Cast Value as a Canvas type
            if(Canvas := canvas[Value]):
                ## Fetch current iteration's UI
                if(PlayerUI := GetPlayerUI[Key]):
                    ## Initialize empty array to store wanted
                    ## canvas slots
                    var WantedSlots : []canvas_slot = array{}
                    
                    ## Iterate current CanvasSlots, if the CanvasSlot does not match any of the
                    ## slots passed in the parameter
                    ## then keep it (add it to WantedSlots)
                    for(CurrentCanvasSlot : Canvas.Slots):
                        var wanted : int = 1 ## Default assumption is slot is wanted (1 --> true)
                        
                        ##Iterate unwanted slots, if any unwanted slot matches the current slot, set wanted to 0 (false)
                        for(UnwatedCanvasSlot : CanvasSlots):
                            if(CurrentCanvasSlot.Widget = UnwantedCanvasSlot.Widget):
                                set wanted = 0

                        if(wanted = 1):
                            WantedSlots = WantedSlots + array{CurrentCanvasSlot}

                    ## Generate new Canvas with wanted slots
                    NewCanvas : canvas = GenerateCanvas(WantedSlots)

                    ## Set current UI for Player
                    PlayerUI.RemoveWidget(Canvas)
                    PlayerUI.AddWidget(NewCanvas)

                    ## Set map to latest UI
                    if(set PlayerCanvases[Player] = NewCanvas):

    
    ## Function that handles adding an array of canvas_slots to a
    ## single player playing
    RemoveSlots(CanvasSlots : []canvas_slot, Player : player) : void =
        ## Iterate through all Players [Key] and their Canvas [Value]
        for(Key -> Value := PlayerCanvases):
            ## Check if current iteration is equal to target
            if(Key = Player):
                ## Cast Value as a Canvas type
                if(Canvas := canvas[Value]):
                    ## Fetch current iteration's UI
                    if(PlayerUI := GetPlayerUI[Key]):
                        ## Initialize empty array to store wanted
                        ## canvas slots
                        var WantedSlots : []canvas_slot = array{}
                        
                        ## Iterate current CanvasSlots, if the CanvasSlot does not match any of the
                        ## slots passed in the parameter
                        ## then keep it (add it to WantedSlots)
                        for(CurrentCanvasSlot : Canvas.Slots):
                            var wanted : int = 1 ## Default assumption is slot is wanted (1 --> true)
                            
                            ##Iterate unwanted slots, if any unwanted slot matches the current slot, set wanted to 0 (false)
                            for(UnwatedCanvasSlot : CanvasSlots):
                                if(CurrentCanvasSlot.Widget = UnwantedCanvasSlot.Widget):
                                    set wanted = 0

                            if(wanted = 1):
                                WantedSlots = WantedSlots + array{CurrentCanvasSlot}

                        ## Generate new Canvas with wanted slots
                        NewCanvas : canvas = GenerateCanvas(WantedSlots)

                        ## Set current UI for Player
                        PlayerUI.RemoveWidget(Canvas)
                        PlayerUI.AddWidget(NewCanvas)

                        ## Set map to latest UI
                        if(set PlayerCanvases[Player] = NewCanvas):

                


