#tag Class
Protected Class WTEC_CellTag
	#tag Property, Flags = &h0, Description = 5468652048696464656E2043656C6C54797065206F6620612043656C6C
		cellType As DesktopListBox.CellTypes = DesktopListBox.CellTypes.Normal
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520757365722043656C6C546167
		userCellTag As Variant = Nil
	#tag EndProperty


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
			InitialValue="-2147483648"
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
			Name="cellType"
			Visible=false
			Group="Behavior"
			InitialValue="DesktopListBox.CellTypes.Default"
			Type="DesktopListBox.CellTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Normal"
				"2 - CheckBox"
				"3 - TextField"
				"4 - TextArea"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
