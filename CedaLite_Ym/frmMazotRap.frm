VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomct2.OCX"
Begin VB.Form frmMazotRap 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Toplam Mazot Raporu"
   ClientHeight    =   4620
   ClientLeft      =   2400
   ClientTop       =   1995
   ClientWidth     =   6615
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4620
   ScaleWidth      =   6615
   StartUpPosition =   2  'CenterScreen
   Begin MSDBGrid.DBGrid grdARAC 
      Bindings        =   "frmMazotRap.frx":0000
      Height          =   3345
      Left            =   180
      OleObjectBlob   =   "frmMazotRap.frx":0016
      TabIndex        =   13
      Top             =   570
      Width           =   2625
   End
   Begin VB.CommandButton btnYAZDIR 
      Appearance      =   0  'Flat
      Caption         =   "&Yazdýr"
      Height          =   435
      Left            =   2610
      TabIndex        =   24
      Top             =   4080
      Width           =   1305
   End
   Begin VB.Frame fraMAIN 
      BorderStyle     =   0  'None
      Height          =   3105
      Left            =   2970
      TabIndex        =   4
      Top             =   600
      Visible         =   0   'False
      Width           =   3525
      Begin VB.TextBox txtTYFarkTL 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   270
         MultiLine       =   -1  'True
         TabIndex        =   23
         Top             =   2760
         Width           =   3195
      End
      Begin VB.TextBox txtFYuzde 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   1710
         MultiLine       =   -1  'True
         TabIndex        =   21
         Top             =   1510
         Width           =   1755
      End
      Begin VB.TextBox txtTopOd 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   1710
         MultiLine       =   -1  'True
         TabIndex        =   16
         Top             =   1185
         Width           =   1755
      End
      Begin VB.TextBox txtFarkTL 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   1710
         MultiLine       =   -1  'True
         TabIndex        =   15
         Top             =   1830
         Width           =   1755
      End
      Begin VB.TextBox txtTYuzde 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   2820
         MultiLine       =   -1  'True
         TabIndex        =   12
         Top             =   2160
         Width           =   645
      End
      Begin VB.TextBox txtYuzde 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   2820
         MultiLine       =   -1  'True
         TabIndex        =   11
         Top             =   860
         Width           =   645
      End
      Begin VB.TextBox txtTKm 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   1710
         MultiLine       =   -1  'True
         TabIndex        =   10
         Top             =   535
         Width           =   1755
      End
      Begin VB.TextBox txtTLitre 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   1710
         MultiLine       =   -1  'True
         TabIndex        =   9
         Top             =   210
         Width           =   1755
      End
      Begin VB.Label Label9 
         Caption         =   "Toplam Lt / Km Yüzdesinden Fark :"
         Height          =   225
         Left            =   210
         TabIndex        =   22
         Top             =   2520
         Width           =   3075
      End
      Begin VB.Label Label8 
         Caption         =   "Fark Yüzdesi:"
         Height          =   225
         Left            =   240
         TabIndex        =   20
         Top             =   1530
         Width           =   1155
      End
      Begin VB.Label Label6 
         Caption         =   "Toplam Ödenen:"
         Height          =   225
         Left            =   240
         TabIndex        =   17
         Top             =   1185
         Width           =   1275
      End
      Begin VB.Label Label5 
         Caption         =   "Fark :"
         Height          =   195
         Left            =   240
         TabIndex        =   14
         Top             =   1875
         Width           =   675
      End
      Begin VB.Label Label4 
         Caption         =   "Toplamda Lt / Km Yüzdesi:"
         Height          =   225
         Left            =   240
         TabIndex        =   8
         Top             =   2190
         Width           =   2055
      End
      Begin VB.Label Label3 
         Caption         =   "Lt / Km Yüzdesi:"
         Height          =   225
         Left            =   240
         TabIndex        =   7
         Top             =   840
         Width           =   1275
      End
      Begin VB.Label Label2 
         Caption         =   "Toplam Km:"
         Height          =   195
         Left            =   240
         TabIndex        =   6
         Top             =   525
         Width           =   945
      End
      Begin VB.Label Label1 
         Caption         =   "Toplam Litre:"
         Height          =   195
         Left            =   240
         TabIndex        =   5
         Top             =   210
         Width           =   945
      End
   End
   Begin VB.CommandButton cmdRAPOR 
      Appearance      =   0  'Flat
      Caption         =   "&Raporla"
      Height          =   435
      Left            =   3930
      TabIndex        =   3
      Top             =   4080
      Width           =   1305
   End
   Begin VB.CommandButton cmdOK 
      Appearance      =   0  'Flat
      Caption         =   "&Tamam"
      Height          =   435
      Left            =   5250
      TabIndex        =   2
      Top             =   4080
      Width           =   1305
   End
   Begin VB.Data TB_ARAC 
      Caption         =   "TB_ARAC"
      Connect         =   "Access"
      DatabaseName    =   "C:\Codes\Kasali\Kasali.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   90
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   2  'Snapshot
      RecordSource    =   "Select AracID,Plaka,LitKm From AracKart Where Ozmal = True Order By Plaka;"
      Top             =   3960
      Visible         =   0   'False
      Width           =   2235
   End
   Begin MSComCtl2.DTPicker Takvim1 
      Height          =   315
      Left            =   150
      TabIndex        =   0
      Top             =   180
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      Format          =   54001665
      CurrentDate     =   36272
   End
   Begin MSComCtl2.DTPicker Takvim2 
      Height          =   315
      Left            =   1680
      TabIndex        =   1
      Top             =   180
      Width           =   1275
      _ExtentX        =   2249
      _ExtentY        =   556
      _Version        =   393216
      Format          =   54001665
      CurrentDate     =   36272
   End
   Begin VB.Label Label7 
      Caption         =   ",Plakalý Aracýn"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   162
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   4080
      TabIndex        =   19
      Top             =   300
      Width           =   2295
   End
   Begin VB.Label lblPLAKA 
      AutoSize        =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   162
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   3120
      TabIndex        =   18
      Top             =   300
      Width           =   75
   End
End
Attribute VB_Name = "frmMazotRap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub btnYAZDIR_Click()
If MsgBox("Yazdýrmak istiyor musunuz?", vbQuestion + vbYesNo, "Yazdýrmaya Onay") = vbNo Then Exit Sub
With Printer
   Printer.Print ""
  .FontName = "Times New Roman Tur"
  .FontSize = 12
  .FontBold = True
  .CurrentX = 1000
  .CurrentY = 2000
  Printer.Print "Toplam Mazot Raporu" + "                     " + Str(Date)
  .FontBold = False
  .CurrentY = 3000
  .CurrentX = 1500
  Printer.Print lblPlaka + " " + Label7 + " " + Str(Takvim1.Value) + " ile " + Str(Takvim2.Value) + " tarihleri arasýndaki raporudur."
  Printer.Print ""
  Printer.Print ""
  Printer.Print ""
  Printer.Print ""
  Printer.Print ""
  .CurrentX = 3000
  Printer.Print Label1 + " " + txtTLitre.Text
  .CurrentX = 3000
  Printer.Print Label2 + " " + txtTKm.Text
  .CurrentX = 3000
  Printer.Print Label3 + " " + txtYuzde.Text
  .CurrentX = 3000
  Printer.Print Label6 + " " + txtTopOd.Text
  .CurrentX = 3000
  Printer.Print Label8 + " " + txtFYuzde.Text
  .CurrentX = 3000
  Printer.Print Label5 + " " + txtFarkTL.Text
  .CurrentX = 3000
  Printer.Print Label4 + " " + txtTYuzde.Text
  .CurrentX = 3000
  Printer.Print Label9 + " " + txtTYFarkTL.Text
  Printer.Print ""
  Printer.Print ""
  Printer.Print ""
  .CurrentX = 6000
  Printer.Print "Rapor Sonu."
 
  .EndDoc
End With
  
  
End Sub

Private Sub cmdOK_Click()
  Unload Me
End Sub

Private Sub cmdRAPOR_Click()
    On Error GoTo hErr
    fraMAIN.Visible = False
    Dim Total, Ara As Recordset
    Dim TotalKmVar, TotalLtVar As Currency
    SQL = "SELECT * From Mazot "
    SQL = SQL & " WHERE (Mazot.Tarih) Between #" & Format(Takvim1.Value, "MM/DD/yyyy") & "# And #" & Format(Takvim2.Value, "MM/DD/yyyy") & "# AND (Mazot.AracID) = " & grdARAC.Columns("AracID").Text & " ORDER BY SiraNo;"
    Set Ara = DB_KaraNak.OpenRecordset(SQL, dbOpenSnapshot)
    Ara.MoveLast
    TotalKmVar = Ara!Km
    Ara.MoveFirst
    TotalKmVar = TotalKmVar - Ara!Km
    Ara.Close
    txtTKm.Text = Format(CStr(TotalKmVar), "#,##.###")
    SQL = "SELECT Sum(Mazot.Litre) AS TotalLt From Mazot "
    SQL = SQL & " WHERE (Mazot.Tarih) Between #" & Format(Takvim1.Value, "MM/DD/yyyy") & "# And #" & Format(Takvim2.Value, "MM/DD/yyyy") & "# AND (Mazot.AracID) = " & grdARAC.Columns("AracID").Text & ";"
    Set Total = DB_KaraNak.OpenRecordset(SQL, dbOpenSnapshot)
    TotalLtVar = Total!TotalLt
    
    SQL = "SELECT Mazot.Litre From Mazot "
    SQL = SQL & " WHERE (Mazot.Tarih) Between #" & Format(Takvim1.Value, "MM/DD/yyyy") & "# And #" & Format(Takvim2.Value, "MM/DD/yyyy") & "# AND (Mazot.AracID) = " & grdARAC.Columns("AracID").Text & " ORDER BY SiraNo;"
    Set Total = DB_KaraNak.OpenRecordset(SQL, dbOpenSnapshot)
    Total.MoveFirst
    TotalLtVar = TotalLtVar - Total!Litre
    
    txtTLitre.Text = Format(CStr(TotalLtVar), "#,##.###")
  
    txtYuzde.Text = Trim(CStr((TotalLtVar / TotalKmVar) * 100))
  
    SQL = "SELECT Sum(Mazot.Litre * Mazot.LitFiyat) AS Total From Mazot "
    SQL = SQL & " WHERE (Mazot.Tarih) Between #" & Format(Takvim1.Value, "MM/DD/yyyy") & "# And #" & Format(Takvim2.Value, "MM/DD/yyyy") & "# AND (Mazot.AracID) = " & grdARAC.Columns("AracID").Text & ";"
    Set Total = DB_KaraNak.OpenRecordset(SQL, dbOpenSnapshot)
    txtTopOd.Text = Format(CStr(Total!Total), "Currency")
  
    If CCur(txtYuzde.Text) > grdARAC.Columns("LitKm").Value Then
        txtFarkTL.Text = Format(Trim(CStr(Total!Total * ((CCur(txtYuzde.Text) - grdARAC.Columns("LitKm").Value) / 100))), "Currency")
        txtFYuzde.Text = Trim(CStr(CCur(txtYuzde.Text) - grdARAC.Columns("LitKm").Value))
    End If
  
    SQL = "SELECT Mazot.Km From Mazot "
    SQL = SQL & " WHERE (Mazot.AracID) = " & grdARAC.Columns("AracID").Text & " ORDER BY SiraNo;"
    Set Total = DB_KaraNak.OpenRecordset(SQL, dbOpenSnapshot)
    Total.MoveLast
    TotalKmVar = Total!Km
    
    Total.MoveFirst
    TotalKmVar = TotalKmVar - Total!Km
  
    SQL = "SELECT Sum(Mazot.Litre) AS TotalLt From Mazot "
    SQL = SQL & " WHERE (Mazot.AracID) = " & grdARAC.Columns("AracID").Text & ";"
    Set Total = DB_KaraNak.OpenRecordset(SQL, dbOpenSnapshot)
    TotalLtVar = Total!TotalLt
    
    SQL = "SELECT Mazot.Litre From Mazot "
    SQL = SQL & " WHERE (Mazot.AracID) = " & grdARAC.Columns("AracID").Text & " ORDER BY SiraNo;"
    Set Total = DB_KaraNak.OpenRecordset(SQL, dbOpenSnapshot)
    Total.MoveFirst
    TotalLtVar = TotalLtVar - Total!Litre
 
    txtTYuzde.Text = Trim(CStr((TotalLtVar / TotalKmVar) * 100))
    
    If CCur(txtTYuzde.Text) > grdARAC.Columns("LitKm").Value Then
      txtTYFarkTL.Text = Format(Trim(CStr(CCur(txtTopOd.Text) * ((CCur(txtTYuzde.Text) - grdARAC.Columns("LitKm").Value) / 100))), "Currency")
    End If
    
    fraMAIN.Visible = True
  
' CSErrorHandler begin - please do not modify or remove this line
Exit Sub
hErr:
    Select Case MsgBox("Hata " & err.Number & ": " & err.Description & vbCrLf & _
               "frmMazotRap.cmdRAPOR_Click." & vbCrLf & _
               "Hatanýn oluþtuðu satýr: " & Erl, _
               vbOKOnly + vbCritical, "Ýlgili Kayýt Yok")
 Case vbOK
     Screen.MousePointer = vbDefault
     Exit Sub
 Case vbRetry
     Resume
 Case vbIgnore
     Resume Next
    End Select
End Sub
Private Sub Form_Load()
  TB_ARAC.DataBaseName = MDBPath
  Takvim2.Value = Date
  
  Takvim1.Value = Format(CDate("01/01/" & Year(Date)), "dd/mm/yyyy")
End Sub

Private Sub grdARAC_RowColChange(LastRow As Variant, ByVal LastCol As Integer)
  lblPlaka.Caption = grdARAC.Columns("Plaka").Text
End Sub
