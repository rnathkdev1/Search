classdef GraphNode < handle
    
    properties
        nextNode;
        state;
        heuristic;
        nodeNum;
    end
    
    
    methods
        
        function this=GraphNode()
            
            this.nodeNum=[];
            this.nextNode=[];
            this.heuristic=[];
            
        end

    end
end

            
        