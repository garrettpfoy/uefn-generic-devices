using { /Fortnite.com/Devices }

resource_device := class(creative_device):

    ## Conditional Button with resource as index[0]
    ## used to determine if player (or players) have
    ## the correct amount of resources for a request
    @editable
    ResourceConditional : conditional_button_device = conditional_button_device{}

    ## Granter device with resource as index[0]
    ## used to give out resources upon request
    @editable
    ResourceGiver : item_granter_device = item_granter_device{}

    ## Helper function that determines
    ## whether or not an agent has at least one
    ## of a resource
    HasResource(Agent : agent) : logic =
        ## Check if resource/item count is greater than 0
        if(ResourceConditional.GetItemCount(Agent, 0) >= 1):
            ## Resource (>0) found, return true
            return true

        ## Otherwise return false
        return false

    ## Helper function that determines whether
    ## or not an agent has a specific amount of 
    ## resources.
    HasResourceAmount(Agent : agent, Amount : int) : logic =
        ## Check if resource/item count is greater than amount
        if(ResourceConditional.GetItemCount(Agent, 0) >= Amount):
            ## Resource (>Amount) found, return true
            return true

        ## Otherwise return false
        return false

    ## Helper function that determines if a team (in form of []agent)
    ## has a threshold amount of resources
    HasResourceAmount(Agents : []agent, Amount : int) : logic =
        ## Check if array has a total amount of resources...
        if(GetResourceAmount(Agents) >= Amount):
            return true
         
        return false

    ## Helper function that determines how many resources
    ## a specific Agent has in their inventory
    GetResourceAmount(Agent : agent) : int =
        return ResourceConditional.GetItemCount(Agent, 0)

    ## Helper function that determines how many resources
    ## an array of Agents have in their inventory
    GetResourceAmount(Agents : []agent) : int = 
        ## Initialize resource counter
        var TeamResources : int = 0

        ## Iterate over "team" ([]agent) and tally resources
        for(Agent : Agents):
            ## Update counter with helper function result
            set TeamResources = TeamResources + GetResourceAmount(Agent)

        return TeamResources

    ## Helper function that removes all resources from
    ## a target player (agent). Returns the amount of items
    ## cleared from a player
    ClearResources(Agent : agent) : int =
        ## First, get the current amount of resources
        ## the player has
        ResourceAmount : int = GetResourceAmount(Agent)

        ## Next, set the conditional to take exactly the amount the
        ## user requires
        ResourceConditional.SetItemCountRequired(0, ResourceAmount)

        ## Now, activate the conditional button to remove all
        ## resources
        ResourceConditional.Activate(Agent)

        ## Set the conditional requirement to 0
        ResourceConditional.SetItemCountRequired(0, 0)

        return ResourceAmount

    ## Helper function that removes all resources from an
    ## array of players (agent). Returns the amount of items cleared
    ## from the array
    ClearResources(Agents : agent[]) : int =
        ## Declare counter for resources cleared
        var AmountCleared : int = 0

        ## Iterate over each Agent
        for(Agent : Agents):
            ## Update counter with result of helper function
            ## that clears an inventory of a resource and returns
            ## how many resources were cleared
            set AmountCleared = AmountCleared + ClearResources(Agent)

        return AmountCleared 
            

    ## Helper function that removes a specific amount of
    ## resources from a target player. Returns true if successful,
    ## false if the player doesn't have enough resources
    RemoveResources(Agent : agent, Amount : int) : logic =
        ## First, get the current amount of resources
        ## the player has
        ResourceAmount : int = GetResourceAmount(Agent)

        if(ResourceAmount < Amount):
            ## Player doesn't have enough resources
            return false
        
        ## Set conditional to Amount
        ResourceConditional.SetItemCountRequired(0, Amount)

        ## Activate conditional to remove Amount of resources
        ResourceConditional.Activate(Agent)

        ## Set conditional back to 0
        ResourceConditional.SetItemCountRequired(0, 0)

        return true

    
    ## Helper method {INTERNAL ONLY} used to actually do the grant function
    ## use GiveResources since it uses async principals
    GiveResource(Agent : agent, Amount : int) : void =

        for(Iteration := 1..Amount):
            ResourceGiver.GrantItem(Agent)

    ## Helper function that adds a specific amount of
    ## resources to a target player.
    GiveResources(Agent : agent, Amount : int) : void =
        ## Iterate for each resource in Amount and grant it, however
        ## since our granter is only one at a time we should do this async
        ## so we don't count to large numbers super slow. Max of 9 async calls
        if(Mod(Amount, 10) = 0):
            ## Amount is a multiple of 10
            Result := sync:
                GiveResource(Agent, Floor(Amount / 10))
                GiveResource(Agent, Floor(Amount / 10))
                GiveResource(Agent, Floor(Amount / 10))
                GiveResource(Agent, Floor(Amount / 10))
                GiveResource(Agent, Floor(Amount / 10))
                GiveResource(Agent, Floor(Amount / 10))
                GiveResource(Agent, Floor(Amount / 10))
                GiveResource(Agent, Floor(Amount / 10))
                GiveResource(Agent, Floor(Amount / 10))
        if else(Mod(Amount, 9) = 0):
            ## Amount is a multiple of 9
            Result := sync:
                GiveResource(Agent, Floor(Amount / 9))
                GiveResource(Agent, Floor(Amount / 9))
                GiveResource(Agent, Floor(Amount / 9))
                GiveResource(Agent, Floor(Amount / 9))
                GiveResource(Agent, Floor(Amount / 9))
                GiveResource(Agent, Floor(Amount / 9))
                GiveResource(Agent, Floor(Amount / 9))
                GiveResource(Agent, Floor(Amount / 9))
                GiveResource(Agent, Floor(Amount / 9))
        if else(Mod(Amount, 8) = 0):
            ## Amount is a multiple of 8
            Result := sync:
                GiveResource(Agent, Floor(Amount / 8))
                GiveResource(Agent, Floor(Amount / 8))
                GiveResource(Agent, Floor(Amount / 8))
                GiveResource(Agent, Floor(Amount / 8))
                GiveResource(Agent, Floor(Amount / 8))
                GiveResource(Agent, Floor(Amount / 8))
                GiveResource(Agent, Floor(Amount / 8))
                GiveResource(Agent, Floor(Amount / 8))
        if else(Mod(Amount, 7) = 0):
            ## Amount is a multiple of 7
            Result := sync:
                GiveResource(Agent, Floor(Amount / 7))
                GiveResource(Agent, Floor(Amount / 7))
                GiveResource(Agent, Floor(Amount / 7))
                GiveResource(Agent, Floor(Amount / 7))
                GiveResource(Agent, Floor(Amount / 7))
                GiveResource(Agent, Floor(Amount / 7))
                GiveResource(Agent, Floor(Amount / 7))
        if else(Mod(Amount, 6) = 0):
            ## Amount is a multiple of 6
            Result := sync:
                GiveResource(Agent, Floor(Amount / 6))
                GiveResource(Agent, Floor(Amount / 6))
                GiveResource(Agent, Floor(Amount / 6))
                GiveResource(Agent, Floor(Amount / 6))
                GiveResource(Agent, Floor(Amount / 6))
                GiveResource(Agent, Floor(Amount / 6))
        if else(Mod(Amount, 5) = 0):
            ## Amount is a multiple of 5
            Result := sync:
                GiveResource(Agent, Floor(Amount / 5))
                GiveResource(Agent, Floor(Amount / 5))
                GiveResource(Agent, Floor(Amount / 5))
                GiveResource(Agent, Floor(Amount / 5))
                GiveResource(Agent, Floor(Amount / 5))
        if else(Mod(Amount, 4) = 0):
            ## Amount is a multiple of 4
            Result := sync:
                GiveResource(Agent, Floor(Amount / 4))
                GiveResource(Agent, Floor(Amount / 4))
                GiveResource(Agent, Floor(Amount / 4))
                GiveResource(Agent, Floor(Amount / 4))
        if else(Mod(Amount, 3) = 0):
            ## Amount is a multiple of 3
            Result := sync:
                GiveResource(Agent, Floor(Amount / 3))
                GiveResource(Agent, Floor(Amount / 3))
                GiveResource(Agent, Floor(Amount / 3))
        if else(Mod(Amount, 2) = 0):
            ## Amount is a multiple of 2
            Result := sync:
                GiveResource(Agent, Floor(Amount / 2))
                GiveResource(Agent, Floor(Amount / 2))
        else {
            ## Amount is one or zero.
            GiveResource(Agent, Amount)
        }



        