#tag Class
Protected Class WTEC_DesktopListbox
Inherits DesktopListBox
	#tag Event
		Sub CellFocusLost(row as Integer, column as Integer)
		  // Set the SUPER CellType to Normal and Raise the Event for Instance
		  
		  #If fDebug
		    System.DebugLog("CellFocusLost on Row " + row.ToString + " in Column " +column.ToString + "set CellType to Normal" )
		  #EndIf 
		  
		  Super.CellTypeAt(row,column) = DesktopListBox.CellTypes.Normal
		  
		  RaiseEvent CellFocusLost(row,column)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function CellPressed(row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
		  // The user has clicked on the Row, Column cell. Row And Column are zero-based.
		  
		  #If fDebug
		    System.DebugLog("CellPressed Event on Row " + row.ToString + " in Column " +column.ToString )
		  #EndIf
		  // ContextKey? Ignore this here in class!
		  If IsContextualClick Then Return RaiseEvent CellPressed(row,column,x,y)
		  
		  
		  Me.prevHit = Me.lastHit.Left : Me.lastHit.Right   // Save the previus clicked Cell
		  Me.lastHit = row : column                                      // Save the actual clicked cell
		  
		  If Me.RowExpandableAt(row) And column = 0 Then
		    // Is a expandable row, check if this click its the Expand Icon
		    If x < TriangleWidth(Me.RowDepthAt(row)) Then 
		      //  the triangle is clicked 
		      Me.lastHit = -1 : -1
		      Me.prevHit = -1 : -1
		      #If fDebug 
		        System.DebugLog("CellPressed Event: Triangle is clicked, Reset Klicked ROW an Column") 
		      #EndIf
		      Return RaiseEvent CellPressed(row,column,x,y)
		    End If
		  End If
		  
		  // =====================
		  // Check SingleClick/DoubleClick
		  // =====================
		  If Me.clickTimer.RunMode = timer.RunModes.Off Then
		    // Timer STOPPED? Then this is NOT a DoubleClick, start clickTimer
		    // If Timer runs out, then the callback Method SingleClick is processed = event SinglePressed
		    Me.clickTimer.RunMode = timer.RunModes.Single
		    #If fDebug
		      System.DebugLog("CellPressed Event: clickTimer is stopped, start the clickTimer")
		    #EndIf
		  Else
		    // clickTimer is running, then this is a DoubleClick, Stop clickTimer and editTimer, Raise DoubleClick Event
		    Me.clickTimer.RunMode = timer.RunModes.Off
		    Me.editTimer.RunMode = timer.RunModes.Off
		    // If CellDoubleClick returns true, raise a DoublePressed event to the instance
		    If RaiseEvent CellDoublePressed(row, column) Then RaiseEvent DoublePressed
		    #If fDebug
		      System.DebugLog("CellPressed Event:  clickTimer is running, Edittimer and ClickTimer areNOW stopped. DoubleClick detected!")
		    #EndIf
		  End If
		  
		  Return RaiseEvent CellPressed(row,column,x,y)
		  
		  
		  
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Closing()
		  // Remove Timer Stuff
		  Me.clickTimer.RunMode = Timer.RunModes.Off
		  RemoveHandler Me.clickTimer.Action, AddressOf SingleClick
		  Me.clickTimer = Nil
		  
		  Me.editTimer.RunMode = Timer.RunModes.Off
		  RemoveHandler Me.editTimer.Action, AddressOf EditTimerEnd
		  Me.EditTimer = Nil
		  
		  
		  RaiseEvent Closing
		End Sub
	#tag EndEvent

	#tag Event
		Sub DoublePressed()
		  // See Documetation
		  RaiseEvent DoublePressed
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  // Init Timer stuff
		  Me.clickTimer = New Timer
		  Me.clickTimer.Period = Me.SingleClickTime
		  Me.clickTimer.Enabled = True
		  Me.clickTimer.RunMode = Timer.RunModes.Off
		  AddHandler Me.clickTimer.Action, AddressOf SingleClick
		  
		  Me.editTimer = New Timer
		  Me.editTimer.Period = Me.EditTimeout
		  Me.editTimer.Enabled = True
		  Me.editTimer.RunMode = Timer.RunModes.Off
		  AddHandler Me.editTimer.Action, AddressOf EditTimerEnd
		  
		  // Init Default Colors, the SubClass can Change the Colors
		  
		  // Colors for a selected Line
		  Me.ColorHighlightText                = New ColorGroup(&cFFFFFF00, &c00000000)
		  Me.ColorHighlightBackground  = New ColorGroup(&c0080FF00 ,&c80FFFF00)
		  
		  // Colors for a Even Row
		  Me.ColorEvenRowText               = New ColorGroup(&c00000000, &cFFFFFF00)
		  Me.ColorEvenRowBackground = New ColorGroup(&cFFFFFF00, &c00000000)
		  
		  // Colors for a Odd Row
		  Me.ColorOddRowText               = New ColorGroup(&c00000000, &cFFFFFF00)
		  Me.ColorOddRowBackground = New ColorGroup(&cF7F7F700, &c67676700)
		  
		  // Initalizize hit pairs
		  lastHit   = -1 : -1
		  prevHit = -1 : -1
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent

	#tag Event
		Function PaintCellBackground(g As Graphics, row As Integer, column As Integer) As Boolean
		  // Colorize/Highlight Background color  if needed
		  
		  Var isRowSelected As Boolean = False   // True if row is selected
		  Var doColorize As Boolean = False
		  Var doHighlight As Boolean = False
		  
		  // Check selection if this is a valid Row
		  If row <= Me.LastRowIndex  Then isRowSelected = Me.RowSelectedAt(row)
		  
		  // Check what todo
		  If Me.colorizeRows Then doColorize = True
		  If Me.HighlightSelection And isRowSelected Then
		    doColorize = False
		    doHighlight = True
		  End If
		  
		  If doColorize And Not Me.HighlightSelection And column = 0 And isRowSelected Then
		    // Disable if Column = 0 
		    doColorize = False
		  End If
		  
		  
		  // Colorize Background
		  If doColorize Then
		    If row Mod 2 = 0 Then
		      // Color for even Rows
		      g.DrawingColor = Me.ColorEvenRowBackground
		    Else
		      // Color for Odd Rows
		      g.DrawingColor = Me.ColorOddRowBackground
		    End If
		  End If
		  
		  If doHighlight Then g.DrawingColor = ColorHighlightBackground
		  
		  // Fill the Cell if needed
		  If doColorize Or doHighlight Then g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Instance can Overwrite the Filling
		  Return RaiseEvent PaintCellBackground(g,row,column)
		  
		  
		  
		End Function
	#tag EndEvent

	#tag Event
		Function PaintCellText(g as Graphics, row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  // This sets only the Textcolor for drawing text !!!!!!
		  
		  Var isRowSelected As Boolean = False
		  Var doColorize As Boolean = False
		  Var doHighlight As Boolean = False
		  
		  // Check selection if this is a valid Row
		  If row <= Me.LastRowIndex  Then isRowSelected = Me.RowSelectedAt(row)
		  
		  // Check what todo
		  If Me.colorizeRows Then doColorize = True
		  If Me.HighlightSelection And isRowSelected Then
		    doColorize = False
		    doHighlight = True
		  End If
		  
		  If doColorize And Not Me.HighlightSelection And column = 0 And isRowSelected Then
		    // Disable if Column = 0 and 
		    doColorize = False
		  End If
		  
		  If doColorize  Then
		    If row Mod 2 = 0 Then
		      
		      g.DrawingColor = Me.ColorEvenRowText  // Text Color for even Rows
		    Else
		      
		      g.DrawingColor = Me.ColorOddRowText   // Text Color for odd Rows
		    End If
		  End If
		  
		  If doHighlight Then g.DrawingColor = ColorHighlightText
		  
		  // Only the Textcolor is set, the Text Drawing is in Instance or in SuperClass
		  Return RaiseEvent PaintCellText(g,row,column,x,y)
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndEvent

	#tag Event
		Function PaintDisclosureWidget(g As Graphics, row As Integer, ByRef x As Integer, ByRef y As Integer, ByRef width As Integer, ByRef height As Integer) As Boolean
		  // Remember the Space for the Triangle/Icon in a expandable Listbox Row
		  // Needed for Calculation in the CellPressed Event
		  
		  If row <= Me.LastRowIndex Then
		    If TriangleWidth.LastIndex < Me.RowDepthAt(row) Then TriangleWidth.Add(0)
		    TriangleWidth(Me.RowDepthAt(row)) = width + x
		  End If
		  
		  Return RaiseEvent PaintDisclosureWidget(g,row,x,y,width,height)
		  
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CellTagAt(row As Integer, column As Integer) As Variant
		  // CellTagAt Override , returns the usertag
		  
		  Var tag As WTEC_CellTag = Me.GetTag(row,column)
		  
		  Return tag.userCellTag
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CellTagAt(row As Integer, column As Integer, Assigns value As Variant)
		  // CellTagAt Override, set the usertag
		  Var tag As WTEC_CellTag = Me.GetTag(row,column)
		  
		  tag.userCellTag = value
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CellTypeAt(row As Integer, column As Integer) As CellTypes
		  // Get a CellType from the WTEC_CellTag, NOT from the Listbox itself (Override)
		  
		  Var tag As WTEC_CellTag = Me.GetTag(row,column)
		  
		  Return tag.cellType
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CellTypeAt(row As Integer, column As Integer, Assigns value As CellTypes)
		  // Set a CellType (Override)
		  
		  Var tag As WTEC_CellTag =Me.GetTag( row, column)   // Read/Generate the Tag
		  
		  // Here we have a valid WTEC_CellTag that is appended to this Cell
		  
		  If value = DesktopListBox.CellTypes.TextArea Or value = DesktopListBox.CellTypes.TextField Then
		    // CellType is Editable, Store this only in the tag
		    tag.cellType = value
		    Super.CellTypeAt(row,column) = DesktopListBox.CellTypes.Normal
		  Else
		    // CellType is NOT Editable, Store this in the tag and the Listbox
		    tag.cellType = value
		    Super.CellTypeAt(row,column) = value
		  End If
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub editTimerEnd(sender as Timer)
		  // Callback: The Timer for EditClick is running out, reset Column & Row
		  
		  #Pragma Unused sender
		  Me.prevHit = -1 : -1
		  
		  #If fDebug
		    System.DebugLog("CALLBACK: editTimerEnd, EditTimer runs out and is stopped by itself")
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTag(row as integer, column as integer) As WTEC_CellTag
		  // This reads the WTEC_CellTag, if none is present, a valid tag is generated
		  
		  Var tag As Variant  = Super.CellTagAt(row,column)
		  Var rTag As WTEC_CellTag
		  
		  // First check if a CellTag present, if not, generate it
		  If Not tag IsA WTEC_CellTag Then
		    // The Tag is NIL or a User Tag
		    If tag = Nil Then
		      // tag is not present, generate Tag and add to celltag (Defaults)
		      rTag = New WTEC_CellTag
		      Super.CellTagAt(row,column) = rTag
		    Else
		      // is a user Tag convert to a WTEC_CellTag
		      rTag = New WTEC_CellTag
		      rTag.userCellTag = tag
		      Super.CellTagAt(row,column) = rTag
		    End If
		  Else
		    // the tag is a WTEC_CellTag
		    rTag = tag
		  End If
		  
		  Return rTag
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function isCellEditable(row as Integer, column as Integer) As Boolean
		  // Check if Cell is editable, this is read from the WTEC_CellTag
		  
		  If row <= Me.LastRowIndex And column <= Me.LastColumnIndex Then
		    Var tag As WTEC_CellTag = Me.GetTag(row,column)
		    
		    Select Case tag.cellType
		    Case  DesktopListBox.CellTypes.TextArea
		      Return True
		    Case  DesktopListBox.CellTypes.TextField
		      Return True
		    End Select
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SingleClick(sender as Timer)
		  // Callback: Click Timer is runnimg out, this was a singleClick
		  
		  #Pragma Unused sender
		  
		  #If fDebug
		    System.DebugLog("Callback SingleClick START ") 
		  #EndIf
		  
		  
		  // Check if clicked Cell is editable (from the WTEC_CellTag, NOT from the Listbox itself!)
		  Var isEditable As Boolean = isCellEditable(Me.lastHit.Left, Me.lastHit.Right)
		  
		  // Check if click is an EditRequest in a Editable cell
		  If Me.editTimer.RunMode = timer.RunModes.Off Then
		    // EditTimer is NOT running, then this is no EditClick
		    #If fDebug
		      System.DebugLog("Callback SingleClick: EditTimer is OFF")
		    #EndIf
		    If isEditable Then
		      // The Cell is Editable, Save the clicked row/column Index, Start the EditTimer
		      Me.prevHit = Me.lastHit.Left : Me.lastHit.Right
		      EditTimer.RunMode = timer.RunModes.Single
		      #If fDebug
		        System.DebugLog("Callback SingleClick: Cell is editable, Save col/row Index and Start EditTimer")
		      #EndIf
		    Else
		      // The Cell is NOT Editable, reset clicked row/column Index, Stop the EditTimer
		      prevHit = -1 : -1
		      EditTimer.RunMode = timer.RunModes.off
		      #If fDebug
		        System.DebugLog("Callback SingleClick: Cell is NOT editable, STOP EditTimer, reset clicked row/column index")
		      #EndIf
		    End If
		  Else
		    // EditTimer is running, then this is a EditClick Check if the Cell is editable
		    If isEditable Then
		      #If fDebug
		        System.DebugLog("Callback SingleClick: EditTimer is running and the Cell is editable")
		      #EndIf
		      If Me.lastHit.Left = Me.prevHit.Left And Me.lastHit.Right = Me.prevHit.Right Then
		        EditTimer.RunMode = timer.RunModes.off
		        Me.prevHit = -1 : -1
		        #If fDebug
		          System.DebugLog("Callback SingleClick: The same Cell was clicked before, STOP EditTimer, Reset lastEditClick..., Raise Event EditClick, Then callback is END")
		        #EndIf
		        If Not RaiseEvent CellEditRequest(lastHit.Left, lastHit.Right) Then
		          // SubClass returns false = Edit allowed
		          Var tag As WTEC_CellTag = Me.GetTag(lastHit.Left,lastHit.Right)
		          // Make this Cell editable (Reset this in event CellFocusLost)
		          Super.CellTypeAt(lastHit.Left, lastHit.Right) = tag.cellType
		          // Start Edit
		          Me.EditCellAt(lastHit.Left,lastHit.Right)
		        End If
		        Return 
		      Else
		        // The Last clicked cell was different
		        EditTimer.RunMode = timer.RunModes.Single
		        #If fDebug
		          System.DebugLog("Callback SingleClick: A different Cell was clicked, Start EditTimer")
		        #EndIf
		      End If
		    Else
		      EditTimer.RunMode = timer.RunModes.Off
		      #If fDebug
		        System.DebugLog("Callback SingleClick: The Cell is NOT editable Stop Edit Timer, Reset lastEditClick ")
		      #EndIf
		    End If
		  End If
		  
		  RaiseEvent CellSinglePressed(lastHit.Left, lastHit.Right)
		  #If fDebug
		    System.DebugLog("Callback SingleClick: Raise SinglePressed Event then  END)")
		  #EndIf
		  
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 4C697374626F782072656365697665642074776F20666173742053696E676C65436C69636B73206F6E207468652073616D6520526F7720262043656C6C
		Event CellDoublePressed(row as Integer, column as Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 4C697374626F78207265717565737473206120696E6C696E65206564697420666F722061206564697461626C652063656C6C0D0A0D0A52657475726E2046616C7365203D20616C6C6F7720746869732C207468652063656C6C20676F657320696E20456469744D6F6465202844656661756C74290D0A52657475726E2054727565203D2069676E6F726520746869732072657175657374
		Event CellEditRequest(row as Integer, column as integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellFocusLost(row as Integer, column as Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellPressed(row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 4C697374626F7820726563656976656420612053696E676C65436C69636B
		Event CellSinglePressed(row as Integer, column as Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865204C697374626F7820697320436C6F736564
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DoublePressed()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865204C697374626F78206973206F70656E6564
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PaintCellBackground(g As Graphics, row As Integer, column As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PaintCellText(g as Graphics, row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 496E766F6B656420666F722068696572617263686963616C204C697374426F786573207768656E20746865206672616D65776F726B206E6565647320746F20647261772074686520646973636C6F7375726520747269616E676C6520666F72206120666F6C64657220726F772E205468697320697320696E766F6B6564206166746572205061696E7443656C6C4261636B67726F756E6420616E64206265666F7265205061696E7443656C6C546578742E
		Event PaintDisclosureWidget(g As Graphics, row As Integer, ByRef x As Integer, ByRef y As Integer, ByRef width As Integer, ByRef height As Integer) As Boolean
	#tag EndHook


	#tag Note, Name = Events
		
		CellSinglePressed:
		The User clicked in a Cell and there are for 250ms no other clicks, see Property SingleClickTime
		
		===============================================================
		
		CellDoublePressed:
		The user clicked fast twice in in the same row & Cell, see Property SingleClickTime
		
		===============================================================
		
		CellEditRequest:
		The user clicked slowly twice in a editable Cell at the same Row & column, the max. Time
		between these clicks is set in Property EditTimeOut. 
		
		Return True  = Don't set the Cell in Editmode
		Return False = Set the Cell in Editmode (This is the Default)
		
		===============================================================
		
		
		
	#tag EndNote

	#tag Note, Name = History
		07.06.2023     V1.0    First release
		
	#tag EndNote

	#tag Note, Name = MIT Licence
		MIT License
		
		Copyright (c) 2023 jogicom
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
		
	#tag EndNote

	#tag Note, Name = SideEffects
		
		There is only ONE known side effect:
		
		If the instance get an CellDoublePressed event, and a modal dialog is ececuted in this event, then  no DoublePressed event is send to the instance. If a DoublePressed event is needed,
		then the CellDoublePressed should return TRUE, this generates a  DoublePressed event.
		
		The Default is FALSE
		
		If the CellDoublePressed returns allways true and there is no ModalDialog, two DoublePressed events are send to the instance.
	#tag EndNote

	#tag Note, Name = ToDo
		
		
	#tag EndNote

	#tag Note, Name = Wie funktioniert es
		German only! Sorry!
		
		Die CellTypes der einzelnen Zellen werden als Schattenkopie in den jeweiligen CellTag geschrieben. 
		
		Ist eine CellType editable, wird dieser CellType nur als SchattenKopie in den CellTag geschrieben, in der Listbox selbst wird diese Zelle auf CellTypes.Normal gesetzt und ist dadurch
		schreibgeschützt und kann durch die SuperClass nicht in den EditMode gehen.
		
		So kann durch die Klasse selbst entschieden werden, ob eine Zelle in den EditMode gehen darf.
		
		Da der CellTag aber auch durch die Instanz genutzt werden kann und dies zu fehlfunktionen führen würde, werden die CellTags in sogenannten Schattenkopien geführt.
		Dazu gibt es die Klasse WTEC_CellTag.
		
		Jedes vorhandene CellTag enthält ein  WTEC_CellTag wo einmal der CellType als Schattenkopie und einmal der UserTag enthalten ist.
		
		Deshalb wurden die vorhanden DesktopListbox Methoden überschrieben, damit dieses Sache für die Instanz transparent ist und keine Seiteneffekte hat
		CellTag At und CellTypeAt
		
		Wo wird ausgewertet:
		
		CellSinglePressed   = callback Methode SingleClick
		CellDoublePressed = CellPressed event in dieser Klasse
		CellEditRequest      = callback Methode SingleClick
	#tag EndNote


	#tag Property, Flags = &h21, Description = 54696D657220666F7220446F75626C652F53696E676C6520436C69636B
		#tag Note
			Timer for Double/Single Click
		#tag EndNote
		Private clickTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732069732074686520436F6C6F7220666F722061206576656E20526F774261636B67726F756E64
		#tag Note
			This is the Color for a even RowBackground, if is Highlighted and  HighlightSelection is true
		#tag EndNote
		ColorEvenRowBackground As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732069732074686520436F6C6F7220666F722061206576656E20526F7754657874
		#tag Note
			This is the Color for a even RowText if Highlighted and  HighlightSelection is true
		#tag EndNote
		ColorEvenRowText As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732069732074686520436F6C6F7220666F72206120486967686C69676874656420526F774261636B67726F756E64
		#tag Note
			This is the Color for a Highlighted RowBackground, if is Highlighted and  HighlightSelection is true
		#tag EndNote
		ColorHighlightBackground As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732069732074686520436F6C6F7220666F72206120486967686C69676874656420526F7754657874
		#tag Note
			This is the Color for a Highligted RowText if Highlighted and  HighlightSelection is true
		#tag EndNote
		ColorHighlightText As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620747275652C205061696E7420746865204261636B67726F756E64206F6620756E73656C656374656420726F7773207769746820646966666572656E7420636F6C6F7273
		colorizeRows As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732069732074686520436F6C6F7220666F722061206F646420526F774261636B67726F756E640D0A
		#tag Note
			This is the Color for a odd RowBackground, if is Highlighted and  HighlightSelection is true
		#tag EndNote
		ColorOddRowBackground As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5075626C69632050726F706572747920436F6C6F724F6464526F775465787420417320436F6C6F7247726F7570
		#tag Note
			This is the Color for a odd RowText if Highlighted and  HighlightSelection is true
		#tag EndNote
		ColorOddRowText As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54696D6520696E206D696C6C697365636F6E647320666F7220612076616C69642045646974206576656E74206265747765656E2074776F2053696E676C6520436C69636B73
		#tag Note
			Time in milliseconds for a valid Edit event between two Single Clicks
		#tag EndNote
		EditTimeout As Integer = 5000
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54696D657220666F722076616C696420456469742074696D65206265747765656E2074776F2073696E676C6520436C69636B73
		Private editTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4D756C7469436F6C756D6E204C697374626F782C20686967686C696768742074686520636F6D706C65746520726F77
		#tag Note
			True = Mark the selectet Row complete With Color
		#tag EndNote
		HighlightSelection As Boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C65667420536964652069732074686520726F772C2074686520726967687420736964652069732074686520636F6C756D6E
		#tag Note
			The left Side is the row, the right side is the column
		#tag EndNote
		Private lastHit As pair
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			The left Side is the row, the right side is the column
		#tag EndNote
		Private prevHit As Pair
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D6178206D696C6C696365636F6E647320776865726520612073696E676C6520436C69636B206973206465746563746564
		#tag Note
			The max milliceconds where a single Click is detected
		#tag EndNote
		SingleClickTime As Integer = 250
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4172726179206F662074686520537061636520466F722074686520547269616E676C652053796D626F6C20496E206120657870616E6461626C6520526F77
		#tag Note
			The Space For the Triangle Symbol In a expandable Row
			
			this value is set in the PaintDisclosureWidget Event and needed for calculation in the CellPressed event
		#tag EndNote
		Private TriangleWidth() As Integer
	#tag EndProperty


	#tag Constant, Name = fDebug, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public, Description = 4966207468697320636F6E7374616E7420697320547275652C207468656E204465627567204D6573736167657320617220656E61626C6564
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLineStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="GridLineStyles"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Horizontal"
				"2 - Vertical"
				"3 - Both"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HighlightSelection"
			Visible=true
			Group="Special"
			InitialValue="true"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="colorizeRows"
			Visible=true
			Group="Special"
			InitialValue="false"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SingleClickTime"
			Visible=true
			Group="Special"
			InitialValue="250"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditTimeout"
			Visible=true
			Group="Special"
			InitialValue="5000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorHighlightText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorHighlightBackground"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorEvenRowBackground"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorEvenRowText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorOddRowBackground"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorOddRowText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
