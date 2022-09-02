#Include "btree.bi"

MakeTree(Double, T1)		'make a double tree, with name T1
Dim b As Boolean			'b as boolean
Dim height As Integer		'height as integer
Dim T As TreeT1				'Dim tree to variable T
Dim pT As TreeT1 Ptr		'pT a pointer to TreeT1 T
pT = @T						'pT points to T

pT->value = 8				'root value

'insert values into tree
Insert(pT, 4)
Insert(pT, 12)
Insert(pT, 2)
Insert(pT, 6)
Insert(pT, 10)
Insert(pT, 14)
Insert(pT, 1)
Insert(pT, 3)
Insert(pT, 5)
Insert(pT, 7)
Insert(pT, 9)
Insert(pT, 11)
Insert(pT, 13)
Insert(pT, 15)
Insert(pT, 15.4)

'print tree
'printPreorder(pT)
printInorder(pT)
'printPostorder(pT)

'search for 6
b=doesNodeExistInBST(pT, 6)
Print "6 is found in tree ? " & b

'search for 5.4
b=doesNodeExistInBST(pT, 5.4)
Print "5.4 is found in tree ? " & b

'get tree height
height = getBinaryTreeHeight(pT)
Print "Binary Tree height=" & height


Sleep
End
