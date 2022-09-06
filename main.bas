#Include "btree.bi"

MakeTree(Double, T1)               'make a double tree structure, with name T1
Dim b As Boolean                   'b as boolean
Dim height As Integer              'height as integer
Dim size As Integer                'size of tree as integer
Dim pT As TreeT1 Ptr = New TreeT1  'initialize a dynamic tree referenced by pointer pT


pT->value = 8                      'root value


'insert values into tree
pT->InsertValue(4)
pT->InsertValue(12)
pT->InsertValue(2)
pT->InsertValue(6)
pT->InsertValue(10)
pT->InsertValue(14)
pT->InsertValue(1)
pT->InsertValue(3)
pT->InsertValue(5)
pT->InsertValue(7)
pT->InsertValue(9)
pT->InsertValue(11)
pT->InsertValue(13)
pT->InsertValue(15)
pT->InsertValue(15.4)


/'
'insert values into tree
pT->InsertValue(7)
pT->InsertValue(6)
pT->InsertValue(5)
pT->InsertValue(4)
pT->InsertValue(3)
pT->InsertValue(2)
pT->InsertValue(1)
pT->InsertValue(0)
'/

'pT->printPreorderValues()
pT->printInorderValues()
'pT->printPostorderValues()

'search for 6
b=pT->existValue(6)
Print "6 is found in tree ? " & b

'search for 5.4
b=pT->existValue(5.4)
Print "5.4 is found in tree ? " & b

'get tree height
height = pT->getTreeHeight()
Print "Binary Tree height=" & height

'get tree size
size = pT->getTreeSize()
Print "Binary Tree size = " & size

'delete node
Print
b=pT->deleteValue(6)
Print "6 is deleted in tree ? " & b
Print
pT->printInorderValues()

'get tree size
size = pT->getTreeSize()
Print "Binary Tree size = " & size

Print
pT->printValuesPaths()

Print
b=pT->removeSeedValue()
Print "seed value is removed from tree ? " & b

Print
pT->printValuesPaths()

Print
pT->InsertValue(8)
Print "old seed value is reinserted into tree"

Print
pT->printValuesPaths()

Delete pT  'delete the full tree

Sleep