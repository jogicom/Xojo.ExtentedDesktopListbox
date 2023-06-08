#tag DesktopWindow
Begin DesktopWindow DemoWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   524
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   732667903
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Listbox Demo"
   Type            =   0
   Visible         =   True
   Width           =   822
   Begin WTEC_DesktopListbox DB_Listbox
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   True
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   True
      AllowRowReordering=   True
      Bold            =   False
      ColorEvenRowBackground=   &c000000
      ColorEvenRowText=   &c000000
      ColorHighlightBackground=   &c000000
      ColorHighlightText=   &c000000
      colorizeRows    =   True
      ColorOddRowBackground=   &c000000
      ColorOddRowText =   &c000000
      ColumnCount     =   3
      ColumnWidths    =   ""
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      EditTimeout     =   5000
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   275
      HighlightSelection=   True
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      SingleClickTime =   250
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   782
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopTextArea TA_Result
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   172
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   325
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   389
   End
   Begin DesktopButton PB_Clear
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Clear Log"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   441
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   383
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   132
   End
   Begin DesktopLabel Label1
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Instance Event Log"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   300
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   389
   End
   Begin DesktopLabel Label2
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   441
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Only test stuff for Class test"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   325
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   361
   End
End
#tag EndDesktopWindow

#tag WindowCode
#tag EndWindowCode

#tag Events DB_Listbox
	#tag Event , Description = 546865204C697374626F78206973206F70656E6564
		Sub Opening()
		  // Fill Demo Text
		  
		  Me.HeaderAt(ListBox.AllColumns) = "Col 0" + Chr(9) + "Col 1" + Chr(9) + "Col 2"
		  
		  // Add a not expandable Row
		  Me.AddRow("Row 1, not expandable", "Row1 Col1 Text", "Row1 Col2 Text")
		  
		  // Add a expandable Row
		  Me.AddRow("Row 2, expandable", "Row2 Col1 Text", "Row2 Col2 Text")
		  Me.RowExpandableAt(Me.LastAddedRowIndex) = True
		  
		  
		  // Make all cells editable
		  For r As Integer = 0 To Me.LastRowIndex
		    For c As Integer= 0 To Me.LastColumnIndex
		      Me.CellTypeAt(r,c) = DesktopListBox.CellTypes.TextField
		    Next
		  Next
		  
		  // Add a normal Row
		  Me.AddRow("Row 3, not  editable", "Row3 Col1 Text", "Row3 Col2 Text")
		  
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub RowExpanded(row As Integer)
		  For childRow As Integer = 0 To 5
		    Me.AddRow("Child Row not editable" + childRow.ToString + " of row " + row.ToString)
		  Next
		  Me.AddRow("Child Row  editable" )
		  me.CellTypeAt(me.LastAddedRowIndex,0) = DesktopListBox.CellTypes.TextField
		  Me.AddExpandableRow("A Expandable Row, not editable")
		  
		  TA_Result.AddText("Expand Row "+ row.ToString+EndOfLine)
		End Sub
	#tag EndEvent
	#tag Event , Description = 4C697374626F7820726563656976656420612053696E676C65436C69636B
		Sub CellSinglePressed(row as Integer, column as Integer)
		  TA_Result.AddText("WTEC SingleClick on Row " + row.ToString + " in Column " + column.ToString+EndOfLine)
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 4C697374626F782072656365697665642074776F20666173742053696E676C65436C69636B73206F6E207468652073616D6520526F7720262043656C6C
		Function CellDoublePressed(row as Integer, column as Integer) As Boolean
		  TA_Result.AddText(" WTEC DoubleClick on Row " + row.ToString + " in Column " + column.ToString + " , Start DemoEditor" +EndOfLine)
		  
		  // Open DemoEditor (modal)
		  DemoEditor.OpenEditor(row,column)
		  Return True   // Raise a DoubleClick Event, because the Modal Dialog prevents the DoublePressed Event!
		End Function
	#tag EndEvent
	#tag Event
		Sub RowCollapsed(row As Integer)
		  TA_Result.AddText("Collapse Row "+ row.ToString+EndOfLine)
		End Sub
	#tag EndEvent
	#tag Event , Description = 4C697374626F78207265717565737473206120696E6C696E65206564697420666F722061206564697461626C652063656C6C0D0A0D0A52657475726E2046616C7365203D20616C6C6F7720746869732C207468652063656C6C20676F657320696E20456469744D6F6465202844656661756C74290D0A52657475726E2054727565203D2069676E6F726520746869732072657175657374
		Function CellEditRequest(row as Integer, column as integer) As Boolean
		  TA_Result.AddText(" WTEC EditClick on Row " + row.ToString + " in Column " + column.ToString + EndOfLine)
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base As DesktopMenuItem, x As Integer, y As Integer) As Boolean
		  #Pragma unused x
		  #Pragma unused y
		  
		  // Add some items
		  base.AddMenu(New DesktopMenuItem("Test 1"))
		  base.AddMenu(New DesktopMenuItem("Test 2"))
		  base.AddMenu(New DesktopMenuItem("Test 3"))
		  
		  // Add a Separator
		  base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  
		  // Add a sub menu
		  Var submenu As New DesktopMenuItem("SubMenu")
		  submenu.AddMenu(New DesktopMenuItem("SubMenu Test 1"))
		  submenu.AddMenu(New DesktopMenuItem("SubMenu Test 2"))
		  submenu.AddMenu(New DesktopMenuItem("SubMenu Test 3"))
		  base.AddMenu(submenu)
		  
		  // Add a Separator
		  base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(selectedItem As DesktopMenuItem) As Boolean
		  #pragma unused selectedItem
		  MessageBox("A menue was cklicked")
		End Function
	#tag EndEvent
	#tag Event
		Function CellPressed(row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
		  TA_Result.AddText(" A normal CellPressed Event at " + row.ToString + " in Column " + column.ToString + EndOfLine)
		End Function
	#tag EndEvent
	#tag Event
		Sub DoublePressed()
		  TA_Result.AddText(" A normal DoublePressed event" +EndOfLine)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PB_Clear
	#tag Event
		Sub Pressed()
		  TA_Result.Text = ""
		End Sub
	#tag EndEvent
#tag EndEvents
