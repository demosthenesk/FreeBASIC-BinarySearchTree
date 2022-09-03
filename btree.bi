#Macro MakeTree(datatype, nameTree)
Type Tree##nameTree
    Public:
        value As datatype
        Declare Sub printPreorder()
        Declare Sub printPostorder()
        Declare Sub printInorder()
        Declare Function doesNodeExistInBST(searchValue As datatype) As Boolean
        Declare Function getBinaryTreeHeight() As Integer
        Declare Sub Insert(value As datatype)
        Declare Destructor()
    Private:
        nodeLeft As Tree##nameTree Ptr
        nodeRight As Tree##nameTree Ptr
        Declare Function addNodeLeft(value As datatype) As Integer
        Declare Function addNodeRight(value As datatype) As Integer
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


Sub Tree##nameTree.printPreorder()
	If @this = 0 Then
		Return
	Endif
	Print this.value & " " 'process node
	this.nodeLeft->printPreorder() 'recurse on left
	this.nodeRight->printPreorder() 'recurse on right
End Sub

Sub Tree##nameTree.printPostorder()
	If @this = 0 Then
		Return
	Endif
	this.nodeLeft->printPreorder() 'recurse on left
	this.nodeRight->printPreorder() 'recurse on right
	Print this.value & " " 'process node
End Sub

Sub Tree##nameTree.printInorder()
	If @this = 0 Then
		Return
	Endif
	this.nodeLeft->printPreorder() 'recurse on left
	Print this.value & " " 'process node
	this.nodeRight->printPreorder() 'recurse on right	
End Sub

Function Tree##nameTree.doesNodeExistInBST(searchValue As datatype) As Boolean
    if @this = 0 Then
        Return False
    elseif this.value = searchValue Then
        Return True
    else
        ' if the node we're at is smaller than the value we're looking for, traverse on the right side
        if searchValue > this.value Then
            Return this.nodeRight->doesNodeExistInBST(searchValue)
        else
            ' if the node we're at is bigger than the value we're looking for, traverse the left side
            Return this.nodeLeft->doesNodeExistInBST(searchValue)
        Endif
    Endif	
End Function

Function Tree##nameTree.getBinaryTreeHeight() As Integer
	If @this = 0 Then
		Return -1
	EndIf

    Dim leftHeight As Integer = this.nodeLeft->getBinaryTreeHeight()
    Dim rightHeight As Integer = this.nodeRight->getBinaryTreeHeight()

    if leftHeight > rightHeight Then
        Return leftHeight + 1
    else
        return rightHeight + 1
    Endif	
End Function

Sub Tree##nameTree.Insert(value As datatype)		
		If this.nodeLeft = 0 Or this.nodeRight = 0 Then		
			If (value < this.value) Then
				this.addNodeLeft(value)
				Return
			Else
				this.addNodeRight(value)
				Return
			Endif
		EndIf

		If this.nodeLeft <> 0 Or this.nodeRight <> 0 Then
			If (value < this.value) Then
				this.nodeLeft->Insert(value)
			Else
				this.nodeRight->Insert(value)
			Endif
		EndIf		
End Sub
#Endmacro