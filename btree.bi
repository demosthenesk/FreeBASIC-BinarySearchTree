#Macro MakeTree(datatype, nameTree)
Type Tree##nameTree
	value As datatype
    nodeLeft As Tree##nameTree Ptr
    nodeRight As Tree##nameTree Ptr
	Declare Function addNodeLeft(value As datatype) As Integer
	Declare Function addNodeRight(value As datatype) As Integer
	Declare Destructor()
End Type

Destructor Tree##nameTree()
	If this.nodeLeft <> 0 Then
		this.value = 0
		Delete this.nodeLeft
	EndIf
	If this.nodeRight <> 0 Then
		this.value = 0
		Delete this.nodeRight
	EndIf
End Destructor

Function Tree##nameTree.addNodeLeft(value As datatype) As Integer
	If this.nodeLeft = 0 Then
		this.nodeLeft = New Tree##nameTree
		this.nodeLeft->value = value
		Return 0
	EndIf
	Return -1
End Function

Function Tree##nameTree.addNodeRight(value As datatype) As Integer
	If this.nodeRight = 0 Then
		this.nodeRight = New Tree##nameTree
		this.nodeRight->value = value
		Return 0
	EndIf
	Return -1
End Function


Sub printPreorder(node As Tree##nameTree Ptr)
	If node = 0 Then
		Return
	Endif
	Print node->value & " " 'process node
	printPreorder(node->nodeLeft) 'recurse on left
	printPreorder(node->nodeRight) 'recurse on right
End Sub

Sub printPostorder(node As Tree##nameTree Ptr)
	If node = 0 Then
		Return
	Endif
	printPreorder(node->nodeLeft) 'recurse on left
	printPreorder(node->nodeRight) 'recurse on right
	Print node->value & " " 'process node
End Sub

Sub printInorder(node As Tree##nameTree Ptr)
	If node = 0 Then
		Return
	Endif
	printPreorder(node->nodeLeft) 'recurse on left
	Print node->value & " " 'process node
	printPreorder(node->nodeRight) 'recurse on right	
End Sub

Function doesNodeExistInBST(bstRoot As Tree##nameTree Ptr, searchValue As datatype) As Boolean
    if bstRoot = 0 Then
        Return False
    elseif bstRoot->value = searchValue Then
        Return True
    else
        ' if the node we're at is smaller than the value we're looking for, traverse on the right side
        if searchValue > bstRoot->value Then
            Return doesNodeExistInBST(bstRoot->nodeRight, searchValue)
        else
            ' if the node we're at is bigger than the value we're looking for, traverse the left side
            Return doesNodeExistInBST(bstRoot->nodeLeft, searchValue)
        Endif
    Endif	
End Function

Function getBinaryTreeHeight(node As Tree##nameTree Ptr) As Integer
	If node = 0 Then
		Return -1
	EndIf

    Dim leftHeight As Integer = getBinaryTreeHeight(node->nodeLeft)
    Dim rightHeight As Integer = getBinaryTreeHeight(node->nodeRight)

    if leftHeight > rightHeight Then
        Return leftHeight + 1
    else
        return rightHeight + 1
    Endif	
End Function

Sub Insert(node As Tree##nameTree Ptr, value As datatype)		
		If node->nodeLeft = 0 Or node->nodeRight = 0 Then		
			If (value < node->value) Then
				node->addNodeLeft(value)
				Return
			Else
				node->addNodeRight(value)
				Return
			Endif
		EndIf

		If node->nodeLeft <> 0 Or node->nodeRight <> 0 Then
			If (value < node->value) Then
				Insert(node->nodeLeft, value)
			Else
				Insert(node->nodeRight, value)
			Endif
		EndIf		
End Sub


#Endmacro
