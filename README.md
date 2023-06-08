# A extended DesktopListbox Class for Xojo

- Supports coloring of rows (odd/even)
- In a multi-column list box, the entire row is highlighted
- Inline edit, if a cell is editable, by slow SingleClicks within a certain time
- No side effects to the functionality of the original DesktopListbox

I developed this class on XOJO 2022R4.1 on Windows 11 and only tested it on Windows.
Unfortunately, I cannot guarantee whether it will work on other platforms.

If you want to contribute special code for other platforms, you are very welcome. If you find any errors, create an issue. It is quite possible that under certain conditions, not everything works as it should.

## What is the difference to DesktopListbox

- The new event **CellDoublePressed** have  two parameter (row, column)

- The new event **CellSinglePressed** only occurs if a click was actually made only once. This event occurs with a time delay (see property SingleClickTime)

- The new event **CellEditRequest** only occurs when two slow SingleClicks have been performed on the same editable cell, within a certain time (see property EditTimeout). It should be **noted** that the **first click triggers a CellSinglePressed event**. In the original ListBox, a second click on the same cell would put it into EditMode, no matter how much time elapsed between clicks. Since this caused confusion for some users, this behavior has been optimized.

- In the original list box (MultiColumn), only the first column is highlighted, when it is selected. By setting the **HighlightSelection** property to true (default), the entire line is automatically highlighted. The colors are DarkMode capable and can be changed at runtime.

- even and odd rows can have different background and text colors. The option can be activated via the **colorizeRows** property (default is off). The colors are DarkMode capable and can be freely determined at runtime.

- All specified default colors can be changed at runtime. For example in the opening event or somewhere else.

  

## The new Propertys

| Property                 | Function                                                     | Type       |
| ------------------------ | ------------------------------------------------------------ | ---------- |
| colorizeRows             | If TRUE, the odd and even rows have different colors, see ColorOdd.... and ColorEven..... | Boolean    |
| HighlightSelection       | If TRUE in MultiColumn Listbox, the hole row is marked as selected, see ColorHighlight..... | Boolean    |
| ColorEvenRowBackground   | Background color for even rows                               | ColorGroup |
| ColorEvenRowText         | Text color for even rows                                     | ColorGroup |
| ColorHighlightBackground | Background color for a selected row                          | ColorGroup |
| ColorHighlightText       | Text color for a selected row                                | ColorGroup |
| ColorOddRowBackground    | Background color for odd rows                                | ColorGroup |
| ColorOddRowText          | Text color for odd rows                                      | ColorGroup |
| SingleClickTime          | Two clicks within this time are evaluated as a DoublePressed event. A  SinglePressed event is delayed by this time. You can adjust this at runtime. (default 250ms) | Integer    |
| EditTimeout              | Two single clicks on the same editable cell immediately triggers an EditCellRequest event, if clicked in this time. You can adjust this at runtime. (default 5000ms) | Integer    |

## The Events in detail

**Event CellDoublePressed(row as Integer, column as Integer)**

```
A double click was performed on a cell in the listbox, on the given row/column.

If you start an modal dialog in this event, no normal DoublePressed event is sent to the instance. 
If you need an DoublePressed event in this situation return TRUE to raise a DoublePressed event.
Default is false. The normal way is: Return allways false!!! See Notes in Class.
```

**Event CellEditRequest(row as Integer, column as integer) As Boolean**

```
The listbox wants to put an editable cell in inline edit mode on the given row/column.
Return TRUE  = Don't set this cell in EditMode
Return FALSE = set this cell in Editmode (default)
```

**Event CellSinglePressed(row as Integer, column as Integer)**

```
A single click was performed on a cell in the listbox, on the given row/column.
```



## Miscellaneous

- There is a flag in the class for debug purposes, if this is set to true, o lot of debug messages are written to the system log (fDebug). Default is false (OFF)
- If you want these functions in your project, import the WTEC_CellTag and WTEC_DesktopListbox classes into your project (see releases).
- I know that my English is far from perfect. I'm happy to accept corrections :-)

## History

| Date/Version | Remarks       |
| ------------ | ------------- |
| 07.06.2023   | First Release |



