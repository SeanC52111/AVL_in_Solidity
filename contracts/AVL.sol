pragma solidity ^0.4.0;

contract AVL{
    struct node{
        uint key;
        uint left;
        uint right;
        uint height;
    }
    mapping(uint => node) nodes;
    uint root=0;
    
    function height(uint n)public constant returns (uint r){
        if(n == 0){
            return 0;
        }else{
            return nodes[n].height;
        }
    }
    
    function max(uint a,uint b)public constant returns(uint r){
        if(a > b)
        return a;
        else 
        return b;
    }
    
    function leftleftrotation(uint k2) public returns(uint r){
        uint k1;
        k1 = nodes[k2].left;
        nodes[k2].left = nodes[k1].right;
        nodes[k1].right = k2;
        
        nodes[k2].height = max(height(nodes[k2].left),height(nodes[k2].right))+1;
        nodes[k1].height = max(height(nodes[k1].left),height(nodes[k1].right))+1;
        return k1;
    }
    
    function rightrightrotation(uint k1)public returns(uint r){
        uint k2;
        k2 = nodes[k1].right;
        nodes[k1].right = nodes[k2].left;
        nodes[k2].left = k1;
        
        nodes[k1].height = max(height(nodes[k1].left),height(nodes[k1].right))+1;
        nodes[k2].height = max(height(nodes[k2].right),height(nodes[k2].left))+1;
        return k2;
    }
    
    function leftrightrotation(uint k3)public returns(uint r){
        nodes[k3].left = rightrightrotation(nodes[k3].left);
        return leftleftrotation(k3);
    }
    
    function rightleftrotation(uint k1)public returns(uint r){
        nodes[k1].right = leftleftrotation(nodes[k1].right);
        return rightrightrotation(k1);
    }
    
    
    function _insert(uint n,uint key)internal returns(uint r){
        if(n==0){
            n = key;
            nodes[n] = node(key,0,0,0);
        }
        else{
            if(key < nodes[n].key){
                nodes[n].left = _insert(nodes[n].left,key);
                
                if(height(nodes[n].left)-height(nodes[n].right)==2){
                    if(key < nodes[nodes[n].left].key){
                        n = leftleftrotation(n);
                    }else{
                        n = leftrightrotation(n);
                    }
                }
                
            }
            else if(key > nodes[n].key){
                nodes[n].right = _insert(nodes[n].right,key);
                
                if(height(nodes[n].right)-height(nodes[n].left)==2){
                    if(key > nodes[nodes[n].right].key){
                        n = rightrightrotation(n);
                    }else{
                        n = rightleftrotation(n);
                    }
                }
            }
        }
        nodes[n].height = max(height(nodes[n].left),height(nodes[n].right))+1;
        return n;
    }
    function insert(uint key)public returns(uint r){
        root = _insert(root,key);
        return root;
    }
    function insertlist(uint[] keys)public{
        for(uint i=0;i<keys.length;i++){
            root = _insert(root,keys[i]);
        }
    }
}
