/'
Developers fxm, demosthenesk
'/
#Macro MakeTree(datatype, nameTree)
Type Tree##nameTree
    Public:
        value As datatype
        Declare Sub printPreorderValues()
        Declare Sub printPostorderValues()
        Declare Sub printInorderValues()
        Declare Function existValue(searchValue As datatype) As Boolean
        Declare Function getTreeHeight() As Integer
        Declare Function getTreeSize() As Integer
        Declare Sub InsertValue(value As datatype)
        Declare Function deleteValue(value As datatype) As Boolean
        Declare Function removeSeedValue() As Boolean
        Declare Sub printValuesPaths(path As String = "seed node")
        Declare Destructor()
    Private:
        nodeLeft As Tree##nameTree Ptr
        nodeRight As Tree##nameTree Ptr
        Declare Function getSize() As Integer
        Declare Function addNodeLeft(value As datatype) As Integer
        Declare Function addNodeRight(value As datatype) As Integer
        Declare Function searchParentNode(value As datatype) Byref As Tree##nameTree
        Declare Sub insertNode(node AS Tree##nameTree)
        Declare Function insertNodeLeft(node AS Tree##nameTree) As Integer
        Declare Function insertNodeRight(node AS Tree##nameTree) As Integer
End Type

Sub Tree##nameTree.printValuesPaths(path As String = "seed node")
    If @This = 0 Then
        Return
    Else
        Print This.value & " ", path
        This.nodeLeft->printValuesPaths(path & " + L")
        This.nodeRight->printValuesPaths(path & " + R")
    End if	
End Sub

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


Function Tree##nameTree.insertNodeLeft(node AS Tree##nameTree) As Integer
	If this.nodeLeft = 0 Then
		this.nodeLeft = @node
		Return 0
	EndIf
	Return -1
End Function

Function Tree##nameTree.insertNodeRight(node AS Tree##nameTree) As Integer
	If this.nodeRight = 0 Then
		this.nodeRight = @node
		Return 0
	EndIf
	Return -1
End Function

Function Tree##nameTree.searchParentNode(value As datatype) Byref As Tree##nameTree
    Static as Tree##nameTree Ptr p
    if this.value = value then
        Return *p
    else
        p = @this
        if value > this.value then
            Return this.nodeRight->searchParentNode(value)
        else
            Return this.nodeLeft->searchParentNode(value)
        end if
    end if
End Function

Sub Tree##nameTree.insertNode(node AS Tree##nameTree)
    If (node.value < this.value) Then
        If this.insertNodeLeft(node) = 0 Then
            Return
        Else
            this.nodeLeft->insertNode(node)
        End If
    Else
        If this.insertNodeRight(node) = 0 Then
            Return
        Else
            this.nodeRight->insertNode(node)
        End If
    End If    
End Sub

Function Tree##nameTree.deleteValue(value As datatype) As Boolean
    If (this.value = value) Or (this.existValue(value) = False) Then
        Return False
    End If
    
    Dim Byref As Tree##nameTree parentNode = this.searchParentNode(value)
    if (parentNode.nodeLeft <> 0) Andalso (parentNode.nodeLeft->value = value) then
        dim as Tree##nameTree ptr p = parentNode.nodeLeft
        parentNode.nodeLeft = p->nodeLeft
        p->nodeLeft = 0
        if p->nodeRight <> 0 then
            this.insertNode(*p->nodeRight)
            p->nodeRight = 0
        end if
        Delete p
    else
        dim as Tree##nameTree ptr p = parentNode.nodeRight
        parentNode.nodeRight = p->nodeRight
        p->nodeRight = 0
        if p->nodeLeft <> 0 then
            this.insertNode(*p->nodeLeft)
            p->nodeLeft = 0
        end if
        Delete p
    end if
    return True
End Function

Function Tree##nameTree.removeSeedValue() As Boolean
    if (this.nodeLeft = 0) And (this.nodeRight = 0) then
        return False
    end if
    
    dim as Tree##nameTree ptr p
    if this.nodeRight <> 0 then
        p = this.nodeRight
        while p->nodeLeft <> 0
            p = p->nodeLeft
        wend
    else
        p = this.nodeLeft
        while p->nodeRight <> 0
            p = p->nodeRight
        wend
    end if
    
    dim byref as Tree##nameTree parentNode = this.searchParentNode(p->value)
    if parentNode.nodeLeft->value = p->value then
        parentNode.nodeLeft = 0
    else
        parentNode.nodeRight = 0
    end if
    
    this.value = p->value
    if p->nodeLeft <> 0 then
        this.insertNode(*p->nodeLeft)
        p->nodeLeft = 0
    end if
    if p->nodeRight <> 0 then
        this.insertNode(*p->nodeRight)
        p->nodeRight = 0
    end if
    delete p
    return True
End Function

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


Sub Tree##nameTree.printPreorderValues()
	If @this = 0 Then
		Return
	Endif
	Print this.value & " " 'process node
	this.nodeLeft->printPreorderValues() 'recurse on left
	this.nodeRight->printPreorderValues() 'recurse on right
End Sub

Sub Tree##nameTree.printPostorderValues()
	If @this = 0 Then
		Return
	Endif
	this.nodeLeft->printPreorderValues() 'recurse on left
	this.nodeRight->printPreorderValues() 'recurse on right
	Print this.value & " " 'process node
End Sub

Sub Tree##nameTree.printInorderValues()
	If @this = 0 Then
		Return
	Endif
	this.nodeLeft->printPreorderValues() 'recurse on left
	Print this.value & " " 'process node
	this.nodeRight->printPreorderValues() 'recurse on right	
End Sub

Function Tree##nameTree.existValue(searchValue As datatype) As Boolean
    if @this = 0 Then
        Return False
    elseif this.value = searchValue Then
        Return True
    else
        ' if the node we're at is smaller than the value we're looking for, traverse on the right side
        if searchValue > this.value Then
            Return this.nodeRight->existValue(searchValue)
        else
            ' if the node we're at is bigger than the value we're looking for, traverse the left side
            Return this.nodeLeft->existValue(searchValue)
        Endif
    Endif	
End Function

Function Tree##nameTree.getTreeHeight() As Integer
	If @this = 0 Then
		Return -1
	EndIf

    Dim leftHeight As Integer = this.nodeLeft->getTreeHeight()
    Dim rightHeight As Integer = this.nodeRight->getTreeHeight()

    if leftHeight > rightHeight Then
        Return leftHeight + 1
    else
        return rightHeight + 1
    Endif	
End Function

Function Tree##nameTree.getTreeSize() As Integer
	If @this = 0 Then
		Return -1
	EndIf
	
	Dim size As Integer = this.getSize()
	Return size-1
End Function

Function Tree##nameTree.getSize() As Integer
	If @this = 0 Then
		Return 1
	Endif
	
	Dim a As Integer = this.nodeLeft->getSize() 'recurse on left
	Dim b As Integer = this.nodeRight->getSize() 'recurse on right	
	Return a + b
End Function

Sub Tree##nameTree.InsertValue(value As datatype)
    If (value < this.value) Then
        If this.addNodeLeft(value) = 0 Then
            Return
        Else
            this.nodeLeft->InsertValue(value)
        End If
    Else
        If this.addNodeRight(value) = 0 Then
            Return
        Else
            this.nodeRight->InsertValue(value)
        End If
    End If    
End Sub
#Endmacro