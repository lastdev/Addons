-- Skew Heap

-- Treates a function that returns a binary tree node
function BinaryTreeNode()
	local newTreeNode = {}
	newTreeNode.root = nil;
	newTreeNode.leftChild = nil;
	newTreeNode.rightChild = nil;
	
	newTreeNode.setRoot = function(newRoot)
		root = newRoot;
	end
	
	newTreeNode.setLeftChild = function(newChild)
		leftChild = newChild;
	end

	newTreeNode.setRightChild = function(newChild)
		rightChild = newChild;
	end
	
	newTreeNode.getRoot = function()
		return root;
	end
	
	return newTreeNode;
end

function Keyed(value, key)
	local newKeyed = {}
	newKeyed.value = value;
	newKeyed.key = key;
	return newKeyed;
end

function SimpleHeap()
	local newHeap = {};
	newHeap.elements = nil;
	newHeap.size = 0;
	
	function newHeap.merge(h1, h2)
		if h1 = nil then
			return h2;
		elseif h2 = nil then
			return h1;
		else
			if h1.root.key > h2.root.key then
				L = h1;
				S = h2;
			else
				L=h2;
				S=h1;
			end
			t = merge(L.rightChild, S)
			L.setRightChild(L.leftChild)
			L.setLeftChild(t)
			return L;
		end
		
	end
	
	function newHeap.put(data, priority)
		--assert(p=number)
		h = BinaryTreeNode();
		h.setRoot(Keyed(daya, priority));
		elements =  merge(elements, h);
		size = size + 1;
	end
	
	function newHeap.maxPriority()
		return elements.root.key;
	end
	
	function newHeap.removeMax()
		x = elements.root.data;
		size = size - 1;
		elements = merge(elements.leftChild, elements.rightChild);
		return x;
	end
	
	return newHeap;
end
