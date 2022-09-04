#Include "btree.bi"

MakeTree(Double, T1)		'make a double tree, with name T1
Dim b As Boolean			'b as boolean
Dim height As Integer		'height as integer
Dim size As Integer			'size of tree as integer
Dim T As TreeT1				'Dim tree to variable T

T.value = 8				'root value


'insert values into tree
T.Insert(4)
T.Insert(12)
T.Insert(2)
T.Insert(6)
T.Insert(10)
T.Insert(14)
T.Insert(1)
T.Insert(3)
T.Insert(5)
T.Insert(7)
T.Insert(9)
T.Insert(11)
T.Insert(13)
T.Insert(15)
T.Insert(15.4)


/'
'insert values into tree
T.Insert(7)
T.Insert(6)
T.Insert(5)
T.Insert(4)
T.Insert(3)
T.Insert(2)
T.Insert(1)
T.Insert(0)
'/

'T.printPreorder()
T.printInorder()
'T.printPostorder()

'search for 6
b=T.doesNodeExistInBST(6)
Print "6 is found in tree ? " & b

'search for 5.4
b=T.doesNodeExistInBST(5.4)
Print "5.4 is found in tree ? " & b

'get tree height
height = T.getBinaryTreeHeight()
Print "Binary Tree height=" & height

'get tree size
size = T.getBinaryTreeSize()
Print "Binary Tree size = " & size

'delete node
Print
b=T.deleteValue(6)
Print "6 is deleted in tree ? " & b
Print
T.printInorder()

'get tree size
size = T.getBinaryTreeSize()
Print "Binary Tree size = " & size


Sleep