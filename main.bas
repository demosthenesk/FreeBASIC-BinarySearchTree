#Include "btree.bi"

MakeTree(Double, T1)               'make a double tree structure, with name T1
Dim b As Boolean                   'b as boolean
Dim height As Integer              'height as integer
Dim size As Integer                'size of tree as integer
Dim pT As TreeT1 Ptr = New TreeT1  'initialize a dynamic tree referenced by pointer pT


pT->value = 8                      'root value


'insert values into tree
pT->Insert(4)
pT->Insert(12)
pT->Insert(2)
pT->Insert(6)
pT->Insert(10)
pT->Insert(14)
pT->Insert(1)
pT->Insert(3)
pT->Insert(5)
pT->Insert(7)
pT->Insert(9)
pT->Insert(11)
pT->Insert(13)
pT->Insert(15)
pT->Insert(15.4)


/'
'insert values into tree
pT->Insert(7)
pT->Insert(6)
pT->Insert(5)
pT->Insert(4)
pT->Insert(3)
pT->Insert(2)
pT->Insert(1)
pT->Insert(0)
'/

'pT->printPreorder()
pT->printInorder()
'pT->printPostorder()

'search for 6
b=pT->doesNodeExistInBST(6)
Print "6 is found in tree ? " & b

'search for 5.4
b=pT->doesNodeExistInBST(5.4)
Print "5.4 is found in tree ? " & b

'get tree height
height = pT->getBinaryTreeHeight()
Print "Binary Tree height=" & height

'get tree size
size = pT->getBinaryTreeSize()
Print "Binary Tree size = " & size

'delete node
Print
b=pT->deleteValue(6)
Print "6 is deleted in tree ? " & b
Print
pT->printInorder()

'get tree size
size = pT->getBinaryTreeSize()
Print "Binary Tree size = " & size

Print
pT->printPath()

Delete pT  'delete the full tree

Sleep