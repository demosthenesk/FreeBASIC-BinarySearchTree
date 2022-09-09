/'
Developers fxm, demosthenesk
'/
#Macro MakeTree(datatype, nameTree)
Type Tree##nameTree
    Public:
        Declare Sub printPreorderValues()
        Declare Sub printPostorderValues()
        Declare Sub printInorderValues()
        Declare Function existValue(value As datatype) As Boolean
        Declare Function getTreeHeight() As Integer
        Declare Function getTreeSize() As Integer
        Declare Sub insertValue(value As datatype)
        Declare Function deleteValue(value As datatype) As Boolean
        Declare Function removeSeedValue() As Boolean
        Declare Sub printValuesPaths(path As String = "seed node")
        Declare Constructor(value As datatype)
        Declare Destructor()
    Private:
        value As datatype
        nodeLeft As Tree##nameTree Ptr
        nodeRight As Tree##nameTree Ptr
        Declare Function getSize() As Integer
        Declare Function addNodeLeft(value As datatype) As Integer
        Declare Function addNodeRight(value As datatype) As Integer
        Declare Function searchParentNode(value As datatype) Byref As Tree##nameTree
        Declare Sub insertNode(node AS Tree##nameTree)
        Declare Function insertNodeLeft(node AS Tree##nameTree) As Integer
        Declare Function insertNodeRight(node AS Tree##nameTree) As Integer
        Declare Constructor()
        Declare Constructor(node AS Tree##nameTree)
        Declare Operator Let(node AS Tree##nameTree)
End Type

Constructor Tree##nameTree(value As datatype)
    This.value = value
End Constructor

Sub Tree##nameTree.printValuesPaths(path As String = "seed node")
    If @This = 0 Then
        Return
    Else
        Print This.value & " ", path
        This.nodeLeft->printValuesPaths(path & " + L")
        This.nodeRight->printValuesPaths(path & " + R")
    End If	
End Sub

Destructor Tree##nameTree()
    If This.nodeLeft <> 0 Then
        This.value = 0
        Delete This.nodeLeft
    End If
    If This.nodeRight <> 0 Then
        This.value = 0
        Delete This.nodeRight
    End If
End Destructor


Function Tree##nameTree.insertNodeLeft(node AS Tree##nameTree) As Integer
    If This.nodeLeft = 0 Then
        This.nodeLeft = @node
        Return 0
    End If
    Return -1
End Function

Function Tree##nameTree.insertNodeRight(node AS Tree##nameTree) As Integer
    If This.nodeRight = 0 Then
        This.nodeRight = @node
        Return 0
    End If
    Return -1
End Function

Function Tree##nameTree.searchParentNode(value As datatype) Byref As Tree##nameTree
    Static as Tree##nameTree Ptr p
    If This.value = value Then
        Return *p
    Else
        p = @This
        If value > this.value Then
            Return This.nodeRight->searchParentNode(value)
        Else
            Return This.nodeLeft->searchParentNode(value)
        End If
    End If
End Function

Sub Tree##nameTree.insertNode(node AS Tree##nameTree)
    If (node.value < This.value) Then
        If This.insertNodeLeft(node) = 0 Then
            Return
        Else
            This.nodeLeft->insertNode(node)
        End If
    Else
        If This.insertNodeRight(node) = 0 Then
            Return
        Else
            This.nodeRight->insertNode(node)
        End If
    End If    
End Sub

Function Tree##nameTree.deleteValue(value As datatype) As Boolean
    If (This.value = value) Or (This.existValue(value) = False) Then
        Return False
    End If
    
    Dim Byref As Tree##nameTree parentNode = This.searchParentNode(value)
    If (parentNode.nodeLeft <> 0) Andalso (parentNode.nodeLeft->value = value) Then
        Dim As Tree##nameTree Ptr p = parentNode.nodeLeft
        parentNode.nodeLeft = p->nodeLeft
        p->nodeLeft = 0
        If p->nodeRight <> 0 Then
            This.insertNode(*p->nodeRight)
            p->nodeRight = 0
        End If
        Delete p
    Else
        Dim As Tree##nameTree Ptr p = parentNode.nodeRight
        parentNode.nodeRight = p->nodeRight
        p->nodeRight = 0
        If p->nodeLeft <> 0 Then
            This.insertNode(*p->nodeLeft)
            p->nodeLeft = 0
        End If
        Delete p
    End If
    Return True
End Function

Function Tree##nameTree.removeSeedValue() As Boolean
    If (This.nodeLeft = 0) And (This.nodeRight = 0) Then
        Return False
    End If
    
    Dim As Tree##nameTree Ptr p
    If This.nodeRight <> 0 Then
        p = This.nodeRight
        While p->nodeLeft <> 0
            p = p->nodeLeft
        Wend
    Else
        p = This.nodeLeft
        While p->nodeRight <> 0
            p = p->nodeRight
        Wend
    End If
    
    Dim Byref As Tree##nameTree parentNode = This.searchParentNode(p->value)
    If parentNode.nodeLeft->value = p->value Then
        parentNode.nodeLeft = 0
    Else
        parentNode.nodeRight = 0
    End If
    
    This.value = p->value
    If p->nodeLeft <> 0 Then
        This.insertNode(*p->nodeLeft)
        p->nodeLeft = 0
    End If
    If p->nodeRight <> 0 Then
        This.insertNode(*p->nodeRight)
        p->nodeRight = 0
    End If
    Delete p
    Return True
End Function

Function Tree##nameTree.addNodeLeft(value As datatype) As Integer
    If This.nodeLeft = 0 Then
        This.nodeLeft = New Tree##nameTree(value)
        Return 0
    End If
    Return -1
End Function

Function Tree##nameTree.addNodeRight(value As datatype) As Integer
    If This.nodeRight = 0 Then
        This.nodeRight = New Tree##nameTree(value)
        Return 0
    End If
    Return -1
End Function

Sub Tree##nameTree.printPreorderValues()
    If @This = 0 Then
        Return
        End If
    Print This.value & " " 'process node
    This.nodeLeft->printPreorderValues() 'recurse on left
    This.nodeRight->printPreorderValues() 'recurse on right
End Sub

Sub Tree##nameTree.printPostorderValues()
    If @This = 0 Then
        Return
    End If
    This.nodeLeft->printPreorderValues() 'recurse on left
    This.nodeRight->printPreorderValues() 'recurse on right
    Print This.value & " " 'process node
End Sub

Sub Tree##nameTree.printInorderValues()
    If @This = 0 Then
        Return
    End If
    This.nodeLeft->printPreorderValues() 'recurse on left
    Print This.value & " " 'process node
    This.nodeRight->printPreorderValues() 'recurse on right	
End Sub

Function Tree##nameTree.existValue(value As datatype) As Boolean
    If @This = 0 Then
        Return False
    Elseif This.value = value Then
        Return True
    Else
        ' if the node we're at is smaller than the value we're looking for, traverse on the right side
        If value > This.value Then
            Return This.nodeRight->existValue(value)
        Else
            ' if the node we're at is bigger than the value we're looking for, traverse the left side
            Return This.nodeLeft->existValue(value)
        End If
    End If	
End Function

Function Tree##nameTree.getTreeHeight() As Integer
    If @This = 0 Then
        Return -1
    End If

    Dim leftHeight As Integer = This.nodeLeft->getTreeHeight()
    Dim rightHeight As Integer = This.nodeRight->getTreeHeight()

    If leftHeight > rightHeight Then
        Return leftHeight + 1
    Else
        Return rightHeight + 1
    End If	
End Function

Function Tree##nameTree.getTreeSize() As Integer
    If @This = 0 Then
        Return -1
    End If
	
    Dim size As Integer = This.getSize()
    Return size-1
End Function

Function Tree##nameTree.getSize() As Integer
    If @This = 0 Then
        Return 1
    End If
	
    Dim a As Integer = This.nodeLeft->getSize() 'recurse on left
    Dim b As Integer = This.nodeRight->getSize() 'recurse on right	
    Return a + b
End Function

Sub Tree##nameTree.insertValue(value As datatype)
    If (value < This.value) Then
        If This.addNodeLeft(value) = 0 Then
            Return
        Else
            This.nodeLeft->insertValue(value)
        End If
    Else
        If This.addNodeRight(value) = 0 Then
            Return
        Else
            This.nodeRight->insertValue(value)
        End If
    End If    
End Sub
#Endmacro