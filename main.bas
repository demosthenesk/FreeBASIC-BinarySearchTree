#Include "btree.bi"

MakeTree(Double, T1)                  'make a double tree structure, with name T1
Dim b As Boolean                      'b as boolean
Dim height As Integer                 'height as integer
Dim size As Integer                   'size of tree as integer
Dim pT As TreeT1 Ptr = New TreeT1(8)  'initialize with 8 a dynamic tree referenced by pointer pT

'insert values into tree
pT->insertValue(4)
pT->insertValue(12)
pT->insertValue(2)
pT->insertValue(6)
pT->insertValue(10)
pT->insertValue(14)
pT->insertValue(1)
pT->insertValue(3)
pT->insertValue(5)
pT->insertValue(7)
pT->insertValue(9)
pT->insertValue(11)
pT->insertValue(13)
pT->insertValue(15)
pT->insertValue(15.4)


/'
'insert values into tree
pT->insertValue(7)
pT->insertValue(6)
pT->insertValue(5)
pT->insertValue(4)
pT->insertValue(3)
pT->insertValue(2)
pT->insertValue(1)
pT->insertValue(0)
'/

'pT->printPreorderValues()
pT->printInorderValues()
'pT->printPostorderValues()

'search for 6
b = pT->existValue(6)
Print "6 is found in tree ? " & b

'search for 5.4
b = pT->existValue(5.4)
Print "5.4 is found in tree ? " & b

'get tree height
height = pT->getTreeHeight()
Print "Binary Tree height=" & height

'get tree size
size = pT->getTreeSize()
Print "Binary Tree size = " & size

'delete node
Print
b = pT->deleteValue(6)
Print "6 is deleted in tree ? " & b
Print
pT->printInorderValues()

'get tree size
size = pT->getTreeSize()
Print "Binary Tree size = " & size

Print
pT->printValuesPaths()

Print
b = pT->removeSeedValue()
Print "seed value is removed from tree ? " & b

Print
pT->printValuesPaths()

Print
pT->insertValue(8)
Print "old seed value is reinserted into tree"

Print
pT->printValuesPaths()

Delete pT  'delete the full tree

Sleep