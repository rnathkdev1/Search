classdef GraphNode < handle
    
    properties
        name;
        left_node;
        center_node;
        right_node;
        % parent_node;
        cost_left;
        cost_center;
        cost_right;
        node_num
    end
    
    
    methods
        function this=GraphNode(name,left_node,center_node,right_node,cost_left,cost_center,cost_right,node_num)
            this.name=name;
            this.left_node=left_node;
            this.right_node=right_node;
            this.center_node=center_node;
            % this.parent_node=parent_node;
            this.cost_left=cost_left;
            this.cost_center=cost_center;
            this.cost_right=cost_right;
            this.node_num=node_num;
            
        end
        
    end
end

            
        