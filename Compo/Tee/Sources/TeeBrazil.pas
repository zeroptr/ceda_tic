unit TeeBrazil;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeBrazilLanguage:TStringList=nil;

Procedure TeeSetBrazil;
Procedure TeeCreateBrazil;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeBrazilConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 por David Berneda';
  TeeMsg_LegendFirstValue   :='Valor da primeira legenda deve ser > 0';
  TeeMsg_LegendColorWidth   :='Largura da cor da legenda deve ser > 0%';
  TeeMsg_SeriesSetDataSource:='Sem gr�fico mestre para validar fonte de dados';
  TeeMsg_SeriesInvDataSource:='Sem fonte de dados v�lida: %s';
  TeeMsg_FillSample         :='Preencher valores de amostra devem ser > 0';
  TeeMsg_AxisLogDateTime    :='Eixo DataHora n�o pode ser Logar�tmico';
  TeeMsg_AxisLogNotPositive :='Valores M�x e M�n de Eixo Logar�tmico devem ser  >= 0';
  TeeMsg_AxisLabelSep       :='% separa��o de Labels deve ser maior que  0';
  TeeMsg_AxisIncrementNeg   :='Incremento de eixo deve ser >= 0';
  TeeMsg_AxisMinMax         :='Valor M�nimo do eixo deve ser <= M�ximo';
  TeeMsg_AxisMaxMin         :='Valor M�ximo do eixo deve ser >= M�nimo';
  TeeMsg_AxisLogBase        :='Base de eixo Logar�tmico deve ser >= 2';
  TeeMsg_MaxPointsPerPage   :='Pontos m�ximos por p�gina devem ser >= 0';
  TeeMsg_3dPercent          :='Percentual de efeito 3D deve estar entre %d e %d';
  TeeMsg_CircularSeries     :='Depend�ncias Circulares entre S�ries n�o permitidas';
  TeeMsg_WarningHiColor     :='16K Cores ou mais requeridas para melhor apresenta��o';

  TeeMsg_DefaultPercentOf   :='%s de %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'de %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='T�tulo do Eixo';
  TeeMsg_AxisLabels         :='R�tulos do Eixo';
  TeeMsg_RefreshInterval    :='Intervalo de atualiza��o deve estar entre 0 e 60';
  TeeMsg_SeriesParentNoSelf :='Gr�fico pai das s�ries n�o pode ser o mesmo!';
  TeeMsg_GalleryLine        :='Linha';
  TeeMsg_GalleryPoint       :='Ponto';
  TeeMsg_GalleryArea        :='�rea';
  TeeMsg_GalleryBar         :='Barra';
  TeeMsg_GalleryHorizBar    :='Barra Horiz.';
  TeeMsg_Stack              :='Pilha';
  TeeMsg_GalleryPie         :='Pizza';
  TeeMsg_GalleryCircled     :='C�rculo';
  TeeMsg_GalleryFastLine    :='Linha R�pida';
  TeeMsg_GalleryHorizLine   :='Linha Horiz';

  TeeMsg_PieSample1         :='Carros';
  TeeMsg_PieSample2         :='Fones';
  TeeMsg_PieSample3         :='Tabelas';
  TeeMsg_PieSample4         :='Monitores';
  TeeMsg_PieSample5         :='L�mpadas';
  TeeMsg_PieSample6         :='Teclados';
  TeeMsg_PieSample7         :='Bicicletas';
  TeeMsg_PieSample8         :='Cadeiras';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editando %s';

  TeeMsg_GalleryStandard    :='Padr�o';
  TeeMsg_GalleryExtended    :='Extendido';
  TeeMsg_GalleryFunctions   :='Fun��es';

  TeeMsg_EditChart          :='E&dita Gr�fico...';
  TeeMsg_PrintPreview       :='&Visualiza Impress�o...';
  TeeMsg_ExportChart        :='E&xporta Gr�fico...';
  TeeMsg_CustomAxes         :='Eixos Personalizados...';

  TeeMsg_InvalidEditorClass :='%s: Classe de Edi��o Inv�lida: %s';
  TeeMsg_MissingEditorClass :='%s: n�o tem Di�logo de Edi��o';

  TeeMsg_GalleryArrow       :='Seta';

  TeeMsg_ExpFinish          :='&Termina';
  TeeMsg_ExpNext            :='&Pr�ximo >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Projeto';
  TeeMsg_GanttSample2       :='Prot�tipo';
  TeeMsg_GanttSample3       :='Desenvolvimento';
  TeeMsg_GanttSample4       :='Vendas';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Teste';
  TeeMsg_GanttSample7       :='Manufat.';
  TeeMsg_GanttSample8       :='Depura��o';
  TeeMsg_GanttSample9       :='Nova Vers�o';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='Muda T�tulo da S�rie';
  TeeMsg_NewSeriesTitle     :='Novo T�tulo da S�rie:';
  TeeMsg_DateTime           :='DataHora';
  TeeMsg_TopAxis            :='Eixo Superior';
  TeeMsg_BottomAxis         :='Eixo Inferior';
  TeeMsg_LeftAxis           :='Eixo Esquerdo';
  TeeMsg_RightAxis          :='Eixo Direito';

  TeeMsg_SureToDelete       :='Exclui %s ?';
  TeeMsg_DateTimeFormat     :='For&mato DataHora:';
  TeeMsg_Default            :='Padr�o';
  TeeMsg_ValuesFormat       :='For&mato Valores:';
  TeeMsg_Maximum            :='M�ximo';
  TeeMsg_Minimum            :='M�nimo';
  TeeMsg_DesiredIncrement   :='% Incremento Desejado';

  TeeMsg_IncorrectMaxMinValue:='Valor Incorreto. Raz�o: %s';
  TeeMsg_EnterDateTime      :='Entre [N�mero de Dias] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Aplicar Mudan�as ?';
  TeeMsg_SelectedSeries     :='(S�rie Selecionada)';
  TeeMsg_RefreshData        :='&Refresca Dados';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='443';
  TeeMsg_FunctionAdd        :='Adiciona';
  TeeMsg_FunctionSubtract   :='Subtrai';
  TeeMsg_FunctionMultiply   :='Multiplica';
  TeeMsg_FunctionDivide     :='Divide';
  TeeMsg_FunctionHigh       :='Maior';
  TeeMsg_FunctionLow        :='Menor';
  TeeMsg_FunctionAverage    :='M�dia';

  TeeMsg_GalleryShape       :='Forma';
  TeeMsg_GalleryBubble      :='Bolha';
  TeeMsg_FunctionNone       :='Copia';

  TeeMsg_None               :='(nenhum)';

  TeeMsg_PrivateDeclarations:='{ Declara��es privadas }';
  TeeMsg_PublicDeclarations :='{ Declara��es p�blicas }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Tamanho do ponteiro deve ser maior que zero';
  TeeMsg_About              :='So&bre TeeChart...';

  tcAdditional              :='Adicionais';
  tcDControls               :='Controle de Dados';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Conjunto de Dados';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Registro �nico';
  TeeMsg_AskDataSource      :='Fonte de &Dados:';

  TeeMsg_Summary            :='Sum�rio';

  TeeMsg_FunctionPeriod     :='Per�odo da Fun��o deve ser >= 0';

  TeeMsg_TeeChartWizard     :='Auxiliar TeeChart';
  TeeMsg_WizardTab          :='Business';

  TeeMsg_ClearImage         :='Lim&pa';
  TeeMsg_BrowseImage        :='V&isualiza...';

  TeeMsg_WizardSureToClose  :='Tem certeza que deseja fechar o TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='Campo %s n�o existe';

  TeeMsg_DepthAxis          :='Prof.Eixo';
  TeeMsg_PieOther           :='Outro';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pizza';
  TeeMsg_ValuesBar          :='Barra';
  TeeMsg_ValuesAngle        :='�ngulo';
  TeeMsg_ValuesGanttStart   :='In�cio';
  TeeMsg_ValuesGanttEnd     :='Final';
  TeeMsg_ValuesGanttNextTask:='Pr�xTarefa';
  TeeMsg_ValuesBubbleRadius :='Raio';
  TeeMsg_ValuesArrowEndX    :='FimX';
  TeeMsg_ValuesArrowEndY    :='FimY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='T�tulo';
  TeeMsg_Foot               :='Rodap�';
  TeeMsg_Period		    :='Per�odo';
  TeeMsg_PeriodRange        :='Faixa Per�odo';
  TeeMsg_CalcPeriod         :='Calcula %s cada:';
  TeeMsg_SmallDotsPen       :='Pontos Pequenos';

  TeeMsg_InvalidTeeFile     :='Gr�fico Inv�lido em arquivo *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Formato de arquivo *.'+TeeMsg_TeeExtension+' incorreto';
  TeeMsg_EmptyTeeFile       :='Arquivo *.'+TeeMsg_TeeExtension+' vazio';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Eixos Gr�fico';
  TeeMsg_ChartAxesCategoryDesc   :='Propriedades e eventos dos Eixos do Gr�fico';
  TeeMsg_ChartWallsCategoryName  :='Paredes Gr�fico';
  TeeMsg_ChartWallsCategoryDesc  :='Propriedades e eventos das Paredes do Gr�fico';
  TeeMsg_ChartTitlesCategoryName :='T�tulos Gr�fico';
  TeeMsg_ChartTitlesCategoryDesc :='Propriedades e eventos dos T�tulos do Gr�fico';
  TeeMsg_Chart3DCategoryName     :='Gr�fico 3D';
  TeeMsg_Chart3DCategoryDesc     :='Propriedades e eventos do Gr�fico 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Personalizado';
  TeeMsg_Series                 :='S�ries';
  TeeMsg_SeriesList             :='Lista de S�ries';

  TeeMsg_PageOfPages            :='P�g. %d de %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Primeiro';
  TeeMsg_Prior  :='Anterior';
  TeeMsg_Next   :='Pr�ximo';
  TeeMsg_Last   :='�ltimo';
  TeeMsg_Insert :='Insere';
  TeeMsg_Delete :='Exclui';
  TeeMsg_Edit   :='Edita';
  TeeMsg_Post   :='Grava';
  TeeMsg_Cancel :='Cancela';

  TeeMsg_All    :='(todos)';
  TeeMsg_Index  :='�ndice';
  TeeMsg_Text   :='Texto';

  TeeMsg_AsBMP        :='como &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='como &Metafile';
  TeeMsg_EMFFilter    :='Metafiles Avan�adas (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Propriedade de painel n�o configurada no formato de Exporta��o';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Sem Borda';
  TeeMsg_Dotted    :='Pontilhado';
  TeeMsg_Colors    :='Cores';
  TeeMsg_Filled    :='Preenchido';
  TeeMsg_Marks     :='Marcas';
  TeeMsg_Stairs    :='Degraus';
  TeeMsg_Points    :='Pontos';
  TeeMsg_Height    :='Altura';
  TeeMsg_Hollow    :='Vazado';
  TeeMsg_Point2D   :='Ponto 2D';
  TeeMsg_Triangle  :='Tri�ngulo';
  TeeMsg_Star      :='Estrela';
  TeeMsg_Circle    :='C�rculo';
  TeeMsg_DownTri   :='Tri.Baixo';
  TeeMsg_Cross     :='Cruz';
  TeeMsg_Diamond   :='Diamante';
  TeeMsg_NoLines   :='Sem Linhas';
  TeeMsg_Stack100  :='Pilha 100%';
  TeeMsg_Pyramid   :='Pir�mide';
  TeeMsg_Ellipse   :='Elipse';
  TeeMsg_InvPyramid:='Pir�mide Inv.';
  TeeMsg_Sides     :='Lados';
  TeeMsg_SideAll   :='Todos Lados';
  TeeMsg_Patterns  :='Padr�es';
  TeeMsg_Exploded  :='Explodido';
  TeeMsg_Shadow    :='Sombra';
  TeeMsg_SemiPie   :='Semi Pizza';
  TeeMsg_Rectangle :='Ret�ngulo';
  TeeMsg_VertLine  :='Linha Vert.';
  TeeMsg_HorizLine :='Linha Horiz.';
  TeeMsg_Line      :='Linha';
  TeeMsg_Cube      :='Cubo';
  TeeMsg_DiagCross :='Cruz Diag.';

  TeeMsg_CanNotFindTempPath    :='Imposs�vel encontrar pasta Tempor�ria';
  TeeMsg_CanNotCreateTempChart :='Imposs�vel criar gr�fico Tempor�rio';
  TeeMsg_CanNotEmailChart      :='Imposs�vel enviar e-mail para TeeChart: %d';

  TeeMsg_SeriesDelete :='Exclui S�rie: ValueIndex %d fora de limites (0 a %d).';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Vela';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Superf�cie';
  TeeMsg_GalleryContour     :='Contorno';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Ponto 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Rosca';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Barra 3D';
  TeeMsg_GalleryBigCandle   :='Vela Grande';
  TeeMsg_GalleryLinePoint   :='Linha Pontos';
  TeeMsg_GalleryHistogram   :='Histograma';
  TeeMsg_GalleryWaterFall   :='Cascata';
  TeeMsg_GalleryWindRose    :='Rosa dos Ventos';
  TeeMsg_GalleryClock       :='Rel�gio';
  TeeMsg_GalleryColorGrid   :='GradeCores';
  TeeMsg_GalleryBoxPlot     :='CaixaPlot';
  TeeMsg_GalleryHorizBoxPlot:='CaixaPlot Horiz.';
  TeeMsg_GalleryBarJoin     :='Jun��o Barras';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pir�mide';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange     :='Grau de polin�mio deve estar entre 1 e 20';
  TeeMsg_AnswerVectorIndex   :='Vetor resposta deve estar entre 1 e %d';
  TeeMsg_FittingError        :='Imposs�vel processar ajuste';
  TeeMsg_PeriodRange         :='Per�odo deve ser >= 0';
  TeeMsg_ExpAverageWeight    :='Peso M�diaExp deve estar entre 0 e 1';
  TeeMsg_GalleryErrorBar     :='Barra Erro';
  TeeMsg_GalleryError        :='Erro';
  TeeMsg_GalleryHighLow      :='Cima-Baixo';
  TeeMsg_FunctionMomentum    :='Momento';
  TeeMsg_FunctionMomentumDiv :='Div.Momento';
  TeeMsg_FunctionExpAverage  :='M�dia Exp.';
  TeeMsg_FunctionMovingAverage:='M�dia M�vel';
  TeeMsg_FunctionExpMovAve   :='M�dia M�vel Exp.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Ajuste Curvas';
  TeeMsg_FunctionTrend       :='Tend�ncia';
  TeeMsg_FunctionExpTrend    :='Tend�ncia Exp.';
  TeeMsg_FunctionLogTrend    :='Tend.Log.';
  TeeMsg_FunctionCumulative  :='Cumulativo';
  TeeMsg_FunctionStdDeviation:='Desvio Pad.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Raiz Quad.M�dia';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Estoc�stico';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Cont.';
  TeeMsg_LoadChart           :='Abrir TeeChart...';
  TeeMsg_SaveChart           :='Salvar TeeChart...';
  TeeMsg_TeeFiles            :='Arquivos TeeChart Pro';

  TeeMsg_GallerySamples      :='Outro';
  TeeMsg_GalleryStats        :='Estat�sticas.';

  TeeMsg_CannotFindEditor    :='Imposs�vel achar formul�rio de edi��o de S�ries: %s';


  TeeMsg_CannotLoadChartFromURL:='C�d.Erro: %d baixando Gr�fico da URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='C�d.Erro: %d baixando dados da S�rie da URL: %s';

  TeeMsg_Test                :='Teste...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='Abre';
  TeeMsg_ValuesHigh          :='Cima';
  TeeMsg_ValuesLow           :='Baixo';
  TeeMsg_ValuesClose         :='Fecha';
  TeeMsg_ValuesOffset        :='Desloc.';
  TeeMsg_ValuesStdError      :='Erro Pad.';

  TeeMsg_Grid3D              :='Grade 3D';

  TeeMsg_LowBezierPoints     :='N�mero de pontos Bezier deve ser > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edita';
  TeeCommanMsg_Print    :='Imprime';
  TeeCommanMsg_Copy     :='Copia';
  TeeCommanMsg_Save     :='Salva';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rota��o: %d� Eleva��o: %d�';
  TeeCommanMsg_Rotate   :='Gira';

  TeeCommanMsg_Moving   :='Desloc.Horiz.: %d Desloc.Vert.: %d';
  TeeCommanMsg_Move     :='Move';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Prof.';

  TeeCommanMsg_Chart    :='Gr�fico';
  TeeCommanMsg_Panel    :='Painel';

  TeeCommanMsg_RotateLabel:='Arraste %s para Girar';
  TeeCommanMsg_MoveLabel  :='Arraste %s para Mover';
  TeeCommanMsg_ZoomLabel  :='Arraste %s para Zoom';
  TeeCommanMsg_DepthLabel :='Arraste %s para dimensionar 3D';

  TeeCommanMsg_NormalLabel:='Arraste bot�o esquerdo para Zoom, bot�o direito para Scroll';
  TeeCommanMsg_NormalPieLabel:='Arraste fatia da Pizza para Explodi-la';

  TeeCommanMsg_PieExploding :='Fatia: %d Explodida: %d %%';

  TeeMsg_TriSurfaceLess:='N�mero de pontos deve ser >= 4';
  TeeMsg_TriSurfaceAllColinear:='Todos pontos colineares';
  TeeMsg_TriSurfaceSimilar:='Pontos semelhantes - imposs�vel executar';
  TeeMsg_GalleryTriSurface:='Sup.Triangular';

  TeeMsg_AllSeries :='Todas S�ries';
  TeeMsg_Edit      :='Edita';

  TeeMsg_GalleryFinancial    :='Financeiro';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Marcas Arraste';
  TeeMsg_AxisArrowTool :='Setas Eixo';
  TeeMsg_DrawLineTool  :='Desenha Linha';
  TeeMsg_NearestTool   :='Ponto Pr�ximo';
  TeeMsg_ColorBandTool :='Faixa Cores';
  TeeMsg_ColorLineTool :='Linha Colorida';
  TeeMsg_RotateTool    :='Gira';
  TeeMsg_ImageTool     :='Imagem';
  TeeMsg_MarksTipTool  :='Marcas Dicas';

  TeeMsg_CantDeleteAncestor  :='Imposs�vel apagar ancestral';

  TeeMsg_Load	         :='Carrega...';
  TeeMsg_NoSeriesSelected:='N�o h� S�rie selecionada';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Gr�fico';
  TeeMsg_CategorySeriesActions :='S�rie Gr�fico';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Muda 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Ativo';
  TeeMsg_ActionSeriesActiveHint :='Mostra / Esconde S�rie';
  TeeMsg_ActionEditHint         :='Edita Gr�fico';
  TeeMsg_ActionEdit             :='&Edita...';
  TeeMsg_ActionCopyHint         :='Copia para �rea de Transfer�ncia';
  TeeMsg_ActionCopy             :='&Copia';
  TeeMsg_ActionPrintHint        :='Visualiza impress�o do Gr�fico';
  TeeMsg_ActionPrint            :='&Imprime...';
  TeeMsg_ActionAxesHint         :='Mostra / Esconde Eixos';
  TeeMsg_ActionAxes             :='&Eixos';
  TeeMsg_ActionGridsHint        :='Mostra / Esconde Grades';
  TeeMsg_ActionGrids            :='&Grades';
  TeeMsg_ActionLegendHint       :='Mostra / Esconde Legenda';
  TeeMsg_ActionLegend           :='&Legenda';
  TeeMsg_ActionSeriesEditHint   :='Edita S�ries';
  TeeMsg_ActionSeriesMarksHint  :='Mostra / Esconde Marcas S�ries';
  TeeMsg_ActionSeriesMarks      :='&Marcas';
  TeeMsg_ActionSaveHint         :='Salva Gr�fico';
  TeeMsg_ActionSave             :='&Salva...';

  TeeMsg_CandleBar              :='Barra';
  TeeMsg_CandleNoOpen           :='Sem Abertura';
  TeeMsg_CandleNoClose          :='Sem Fechamento';
  TeeMsg_NoLines                :='Sem Linhas';
  TeeMsg_NoHigh                 :='Sem Cima';
  TeeMsg_NoLow                  :='Sem Baixo';
  TeeMsg_ColorRange             :='Faixa de Cores';
  TeeMsg_WireFrame              :='Wireframe';
  TeeMsg_DotFrame               :='Moldura Pontos';
  TeeMsg_Positions              :='Posi��es';
  TeeMsg_NoGrid                 :='Sem Grade';
  TeeMsg_NoPoint                :='Sem Pontos';
  TeeMsg_NoLine                 :='Sem Linha';
  TeeMsg_Labels                 :='R�tulos';
  TeeMsg_NoCircle               :='Sem C�rculo';
  TeeMsg_Lines                  :='Linhas';
  TeeMsg_Border                 :='Borda';

  TeeMsg_SmithResistance      :='Resist�ncia';
  TeeMsg_SmithReactance       :='Reat�ncia';
  
  TeeMsg_Column               :='Coluna';

  { 5.01 }
  TeeMsg_Separator            :='Separador';
  TeeMsg_FunnelSegment        :='Segmento ';
  TeeMsg_FunnelSeries         :='Funil';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Excede cota';
  TeeMsg_FunnelWithin         :=' dentro da cota';
  TeeMsg_FunnelBelow          :=' ou mais abaixo da cota';
  TeeMsg_CalendarSeries       :='Calend�rio';
  TeeMsg_DeltaPointSeries     :='DeltaPonto';
  TeeMsg_ImagePointSeries     :='ImagemPonto';
  TeeMsg_ImageBarSeries       :='ImagemBarra';
  TeeMsg_SeriesTextFieldZero  :='TextoS�rie: �ndice de campo deve ser maior que zero.';

  { 5.02 }
  TeeMsg_Origin               := 'Origem';
  TeeMsg_Transparency         := 'Transpar�ncia';
  TeeMsg_Box		      := 'Caixa';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'N�mero P�gina';

  { 5.03 }
  TeeMsg_Gradient             :='Gradiente';
  TeeMsg_WantToSave           :='Salva %s?';

  TeeMsg_Property             :='Propriedade';
  TeeMsg_Value                :='Valor';
  TeeMsg_Yes                  :='Sim';
  TeeMsg_No                   :='N�o';
  TeeMsg_Image                :='(imagem)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Ponto Arraste';
  TeeMsg_OpportunityValues    := 'Valores Oportunidade';
  TeeMsg_QuoteValues          := 'Valores Cota';


  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'Vers�o ActiveX ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Imposs�vel importar TeeChart de %s';
  TeeMsg_ActiveXVerbPrint    := 'Visuali&za Impress�o...';
  TeeMsg_ActiveXVerbExport   := 'E&xporta...';
  TeeMsg_ActiveXVerbImport   := '&Importa...';
  TeeMsg_ActiveXVerbHelp     := '&Ajuda...';
  TeeMsg_ActiveXVerbAbout    := '&Sobre TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: C�d.Erro: %d baixando: %s';
  TeeMsg_DatasourceError     := 'Fonte de dados n�o � uma s�rie ou set gravado';
  TeeMsg_SeriesTextSrcError  := 'Tipo de S�rie Inv�lido';
  TeeMsg_AxisTextSrcError    := 'Tipo de Eixo Inv�lido';
  TeeMsg_DelSeriesDatasource := 'Confirma exclus�o de %s ?';
  TeeMsg_OCXNoPrinter        := 'N�o h� impressora padr�o instalada.';
  TeeMsg_ActiveXPictureNotValid:='Figura inv�lida';
  {$ENDIF}

  // 6.0

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='como &PDF';
  TeeMsg_PDFFilter        :='arquivos PDF (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='como PostScript';
  TeeMsg_PSFilter         :='arquivos PostScript (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='�rea'#13'Horizontal';
  TeeMsg_SelfStack        :='Empilhada';
  TeeMsg_DarkPen          :='Borda Escura';
  TeeMsg_SelectFolder     :='Selecione pasta de banco de dados';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Conex�o:';

  // 6.0 Pro

  TeeMsg_FunctionSmooth       :='Suaviza��o';
  TeeMsg_FunctionCross        :='Pontos Cruzados';
  TeeMsg_GridTranspose        :='Transp�e Grade 3D';
  TeeMsg_FunctionCompress     :='Compress�o';
  TeeMsg_ExtraLegendTool      :='Legenda Extra';
  TeeMsg_FunctionCLV          :='Valor'#13'Local Pr�ximo';
  TeeMsg_FunctionOBV          :='Volume'#13'Balanceado';
  TeeMsg_FunctionCCI          :='�ndice de Canal'#13'Commodity';
  TeeMsg_FunctionPVO          :='Oscilador'#13'Volume';
  TeeMsg_SeriesAnimTool       :='Anima��o de S�ries';
  TeeMsg_GalleryPointFigure   :='Ponto & Figura';
  TeeMsg_Up                   :='Cima';
  TeeMsg_Down                 :='Baixo';
  TeeMsg_GanttTool            :='Arrasta Gantt';
  TeeMsg_XMLFile              :='Arquivo XML';
  TeeMsg_GridBandTool         :='Ferramenta de faixa de Grade';
  TeeMsg_FunctionPerf         :='Performance';
  TeeMsg_GalleryGauge         :='Medidor';
  TeeMsg_GalleryGauges        :='Medidores';
  TeeMsg_ValuesVectorEndZ     :='Fim do VetorZ';
  TeeMsg_GalleryVector3D      :='Vetor 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Torre';
  TeeMsg_SingleColor          :='Cor Simples';
  TeeMsg_Cover                :='Capa';
  TeeMsg_Cone                 :='Cone';
  TeeMsg_PieTool              :='Fatias Pizza';

  // 7.0
  TeeMsg_View2D               :='2D';
  TeeMsg_Outline              :='Linha Externa';

  TeeMsg_Stop                 :='Parar';
  TeeMsg_Execute              :='Executa !';
  TeeMsg_Themes               :='Temas';
  TeeMsg_LightTool            :='Ilumina��o 2D';
  TeeMsg_Current              :='Atual';
  TeeMsg_FunctionCorrelation  :='Correla��o';
  TeeMsg_FunctionVariance     :='Vari�ncia';
  TeeMsg_GalleryBubble3D      :='Bolha 3D';
  TeeMsg_GalleryHorizHistogram:='Histograma'#13'Horizontal';
  TeeMsg_FunctionPerimeter    :='Per�metro';
  TeeMsg_SurfaceNearestTool   :='Superf�cie Pr�xima';
  TeeMsg_AxisScrollTool       :='Rolagem do Eixo';
  TeeMsg_RectangleTool        :='Ret�ngulo';
  TeeMsg_GalleryPolarBar      :='Barra Polar';
  TeeMsg_AsWapBitmap          :='Bitmap WAP';
  TeeMsg_WapBMPFilter         :='Bitmaps WAP (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='Trunca S�rie';
  TeeMsg_SeriesBandTool       :='Faixa de S�ries';
end;

Procedure TeeCreateBrazil;
begin
  if not Assigned(TeeBrazilLanguage) then
  begin
    TeeBrazilLanguage:=TStringList.Create;
    TeeBrazilLanguage.Text:=

'GRADIENT EDITOR=Editor Gradiente'#13+
'GRADIENT=Gradiente'#13+
'DIRECTION=Dire��o'#13+
'VISIBLE=Vis�vel'#13+
'TOP BOTTOM=Cima Baixo'#13+
'BOTTOM TOP=Baixo Cima'#13+
'LEFT RIGHT=Esquerda Direita'#13+
'RIGHT LEFT=Direita Esquerda'#13+
'FROM CENTER=Do Centro'#13+
'FROM TOP LEFT=De Cima Esquerda'#13+
'FROM BOTTOM LEFT=De Baixo Esquerda'#13+
'OK=Ok'#13+
'CANCEL=Cancela'#13+
'COLORS=Cores'#13+
'START=In�cio'#13+
'MIDDLE=Meio'#13+
'END=Final'#13+
'SWAP=Troca'#13+
'NO MIDDLE=Sem Meio'#13+
'TEEFONT EDITOR=Editor TeeFont'#13+
'INTER-CHAR SPACING=Espa�o Inter-caracter'#13+
'FONT=Fonte'#13+
'SHADOW=Sombra'#13+
'COLOR=Cor'#13+
'OUTLINE=Contorno'#13+
'OPTIONS=Op��es'#13+
'FORMAT=Formato'#13+
'TEXT=Texto'#13+
'POSITION=Posi��o'#13+
'LEFT=Esquerda'#13+
'TOP=Cima'#13+
'AUTO=Auto'#13+
'CUSTOM=Person.'#13+
'LEFT TOP=Sup.Esq.'#13+
'LEFT BOTTOM=Inf.Esq.'#13+
'RIGHT TOP=Dup.Dir.'#13+
'RIGHT BOTTOM=Inf.Dir.'#13+
'MULTIPLE AREAS=M�ltiplas �reas'#13+
'NONE=Nenhum'#13+
'STACKED=Empilhado'#13+
'STACKED 100%=Empilhado 100%'#13+
'AREA=�rea'#13+
'PATTERN=Padr�o'#13+
'STAIRS=Degraus'#13+
'SOLID=S�lido'#13+
'CLEAR=Vazio'#13+
'HORIZONTAL=Horizontal'#13+
'VERTICAL=Vertical'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Cruz'#13+
'DIAG.CROSS=Cruz Diag.'#13+
'AREA LINES=Linhas de �rea'#13+
'BORDER=Borda'#13+
'INVERTED=Invertido'#13+
'COLOR EACH=Colore cada'#13+
'ORIGIN=Origem'#13+
'USE ORIGIN=Usa Origem'#13+
'WIDTH=Largura'#13+
'HEIGHT=Altura'#13+
'AXIS=Eixo'#13+
'SCROLL=Rolar'#13+
'BOTH=Ambos'#13+
'AXIS INCREMENT=Incremento do Eixo'#13+
'INCREMENT=Incremento'#13+
'STANDARD=Padr�o'#13+
'ONE MILLISECOND=Um Milisegundo'#13+
'ONE SECOND=Um Segundo'#13+
'FIVE SECONDS=Cinco Segundos'#13+
'TEN SECONDS=Dez Segundos'#13+
'FIFTEEN SECONDS=Quinze Segundos'#13+
'THIRTY SECONDS=Trinta Segundos'#13+
'ONE MINUTE=Um Minuto'#13+
'FIVE MINUTES=Cinco Minutos'#13+
'TEN MINUTES=Dez Minutos'#13+
'FIFTEEN MINUTES=Quinze Minutos'#13+
'THIRTY MINUTES=Trinta Minutos'#13+
'ONE HOUR=Uma Hora'#13+
'TWO HOURS=Duas Horas'#13+
'SIX HOURS=Seis Horas'#13+
'TWELVE HOURS=Doze Horas'#13+
'ONE DAY=Um Dia'#13+
'TWO DAYS=Dois Dias'#13+
'THREE DAYS=Tr�s Dias'#13+
'ONE WEEK=Uma Semana'#13+
'HALF MONTH=Meio M�s'#13+
'ONE MONTH=Um M�s'#13+
'TWO MONTHS=Dois Meses'#13+
'THREE MONTHS=Tres Meses'#13+
'FOUR MONTHS=Quatro Meses'#13+
'SIX MONTHS=Seis Meses'#13+
'ONE YEAR=Um Ano'#13+
'EXACT DATE TIME=Data Hora Exata'#13+
'AXIS MAXIMUM AND MINIMUM=M�ximo e M�nimo do Eixo'#13+
'VALUE=Valor'#13+
'TIME=Hora'#13+
'LEFT AXIS=Eixo Esquerdo'#13+
'RIGHT AXIS=Eixo Direito'#13+
'TOP AXIS=Eixo Superior'#13+
'BOTTOM AXIS=Eixo Inferior'#13+
'% BAR WIDTH=% Larg.Barra'#13+
'STYLE=Estilo'#13+
'% BAR OFFSET=% Desl.Barra'#13+
'RECTANGLE=Ret�ngulo'#13+
'PYRAMID=Pir�mide'#13+
'INVERT. PYRAMID=Pir�mide Invert.'#13+
'CYLINDER=Cilindro'#13+
'ELLIPSE=Elipse'#13+
'ARROW=Seta'#13+
'RECT. GRADIENT=Gradiente Ret.'#13+
'CONE=Cone'#13+
'DARK BAR 3D SIDES=Lados 3D Barra Escuros'#13+
'BAR SIDE MARGINS=Margens Laterais Barra'#13+
'AUTO MARK POSITION=Marca Posi��o Auto'#13+
'JOIN=Jun��o'#13+
'DATASET=Dataset'#13+
'APPLY=Aplica'#13+
'SOURCE=Fonte'#13+
'MONOCHROME=Monocrom�tico'#13+
'DEFAULT=Padr�o'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Mediana'#13+
'WHISKER=Fio'#13+
'PATTERN COLOR EDITOR=Editor de Padr�o de Cores'#13+
'IMAGE=Imagem'#13+
'BACK DIAGONAL=Diagonal Inv.'#13+
'DIAGONAL CROSS=Cruz Diagonal'#13+
'FILL 80%=Preenche 80%'#13+
'FILL 60%=Preenche 60%'#13+
'FILL 40%=Preenche 40%'#13+
'FILL 20%=Preenche 20%'#13+
'FILL 10%=Preenche 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=Vertical pequeno'#13+
'HORIZ. SMALL=Horiz. pequeno'#13+
'DIAG. SMALL=Diag. pequeno'#13+
'BACK DIAG. SMALL=Diag. Inv. pequeno'#13+
'CROSS SMALL=Cruz pequena'#13+
'DIAG. CROSS SMALL=Cruz Diag. pequena'#13+
'DAYS=Dias'#13+
'WEEKDAYS=Dias da Semana'#13+
'TODAY=Hoje'#13+
'SUNDAY=Domingo'#13+
'TRAILING=Faltando'#13+
'MONTHS=Meses'#13+
'LINES=Linhas'#13+
'SHOW WEEKDAYS=Mostra Dias Semana'#13+
'UPPERCASE=Caixa Alta'#13+
'TRAILING DAYS=Dias Faltando'#13+
'SHOW TODAY=Mostra Hoje'#13+
'SHOW MONTHS=Mostra Meses'#13+
'SHOW PREVIOUS BUTTON=Mostra Bot�o Anterior'#13+
'SHOW NEXT BUTTON=Mostra Bot�o Pr�ximo'#13+
'CANDLE WIDTH=Largura Vela'#13+
'STICK=Bast�o'#13+
'BAR=Barra'#13+
'OPEN CLOSE=Abre Fecha'#13+
'UP CLOSE=Fecha Cima'#13+
'DOWN CLOSE=Fecha Baixo'#13+
'SHOW OPEN=Mostra Aberto'#13+
'SHOW CLOSE=Mostra Fech.'#13+
'DRAW 3D=Des. 3D'#13+
'DARK 3D=3D Escuro'#13+
'EDITING=Editando'#13+
'CHART=Gr�fico'#13+
'SERIES=S�ries'#13+
'DATA=Dados'#13+
'TOOLS=Ferramentas'#13+
'EXPORT=Exporta'#13+
'PRINT=Imprime'#13+
'GENERAL=Geral'#13+
'TITLES=T�tulos'#13+
'LEGEND=Legenda'#13+
'PANEL=Painel'#13+
'PAGING=Pagina��o'#13+
'WALLS=Paredes'#13+
'3D=3D'#13+
'ADD=Adiciona'#13+
'DELETE=Apaga'#13+
'TITLE=T�tulo'#13+
'CLONE=Clone'#13+
'CHANGE=Altera'#13+
'HELP=Ajuda'#13+
'CLOSE=Fecha'#13+
'TEECHART PRINT PREVIEW=Visualiza��o de Impress�o do TeeChart'#13+
'PRINTER=Impressora'#13+
'SETUP=Config'#13+
'ORIENTATION=Orienta��o'#13+
'PORTRAIT=Retrato'#13+
'LANDSCAPE=Paisagem'#13+
'MARGINS (%)=Margens (%)'#13+
'DETAIL=Detalhe'#13+
'MORE=Mais'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Reinic.Margens'#13+
'VIEW MARGINS=Vis.Margins'#13+
'PROPORTIONAL=Proporcional'#13+
'CIRCLE=C�rculo'#13+
'VERTICAL LINE=Linha Vertical'#13+
'HORIZ. LINE=Linha Horiz.'#13+
'TRIANGLE=Tri�ngulo'#13+
'INVERT. TRIANGLE=Tri�ngulo Invert.'#13+
'LINE=Linha'#13+
'DIAMOND=Diamante'#13+
'CUBE=Cubo'#13+
'STAR=Estrela'#13+
'TRANSPARENT=Transparente'#13+
'HORIZ. ALIGNMENT=Alinhamento Horiz.'#13+
'RIGHT=Direita'#13+
'ROUND RECTANGLE=Ret�ngulo Arredondado'#13+
'ALIGNMENT=Alinhamento'#13+
'BOTTOM=Baixo'#13+
'UNITS=Unidades'#13+
'PIXELS=Pixels'#13+
'AXIS ORIGIN=Origem Eixo'#13+
'ROTATION=Rota��o'#13+
'CIRCLED=Circular'#13+
'3 DIMENSIONS=3 Dimens�es'#13+
'RADIUS=Raio'#13+
'ANGLE INCREMENT=Incremento �ngulo'#13+
'RADIUS INCREMENT=Incremento Raio'#13+
'CLOSE CIRCLE=Fecha C�rculo'#13+
'PEN=Caneta'#13+
'LABELS=R�tulos'#13+
'ROTATED=Girado'#13+
'CLOCKWISE=Hor�rio'#13+
'INSIDE=Dentro'#13+
'ROMAN=Romanos'#13+
'HOURS=Horas'#13+
'MINUTES=Minutos'#13+
'SECONDS=Segundos'#13+
'START VALUE=Valor Inicial'#13+
'END VALUE=Valor Final'#13+
'TRANSPARENCY=Transpar�ncia'#13+
'DRAW BEHIND=Desenha Atr�s'#13+
'COLOR MODE=Modo Cores'#13+
'RANGE=Faixa'#13+
'PALETTE=Paleta'#13+
'PALE=P�lido'#13+
'STRONG=Forte'#13+
'GRID SIZE=Tam. Grade'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Prof.'#13+
'IRREGULAR=Irregular'#13+
'GRID=Grade'#13+
'ALLOW DRAG=Permite Arrastar'#13+
'VERTICAL POSITION=Posi��o Vertical'#13+
'LEVELS POSITION=Posi��o N�veis'#13+
'LEVELS=N�veis'#13+
'NUMBER=N�mero'#13+
'LEVEL=N�vel'#13+
'AUTOMATIC=Autom�tico'#13+
'SNAP=Encaixa'#13+
'FOLLOW MOUSE=Segue mouse'#13+
'STACK=Empilha'#13+
'HEIGHT 3D=Altura 3D'#13+
'LINE MODE=Modo Linha'#13+
'OVERLAP=Sobrep�e'#13+
'STACK 100%=Empilha 100%'#13+
'CLICKABLE=Clic�vel'#13+
'AVAILABLE=Dispon�vel'#13+
'SELECTED=Selecionado'#13+
'DATASOURCE=Fonte de Dados'#13+
'GROUP BY=Agrupa por'#13+
'CALC=Calc'#13+
'OF=de'#13+
'SUM=Soma'#13+
'COUNT=Contagem'#13+
'HIGH=Maior'#13+
'LOW=Menor'#13+
'AVG=M�dia'#13+
'HOUR=Hora'#13+
'DAY=Dia'#13+
'WEEK=Semana'#13+
'WEEKDAY=Dia da Semana'#13+
'MONTH=M�s'#13+
'QUARTER=Trimestre'#13+
'YEAR=Ano'#13+
'HOLE %=Buraco %'#13+
'RESET POSITIONS=Reinicializa posi��es'#13+
'MOUSE BUTTON=Bot�o Mouse'#13+
'ENABLE DRAWING=Habilita desenho'#13+
'ENABLE SELECT=Habilita Sele��o'#13+
'ENHANCED=Avan�ado'#13+
'ERROR WIDTH=Larg. Erro'#13+
'WIDTH UNITS=Unids Larg.'#13+
'PERCENT=Percent.'#13+
'LEFT AND RIGHT=Esquerda e Direita'#13+
'TOP AND BOTTOM=Cima e Baixo'#13+
'BORDER EDITOR=Editor Bordas'#13+
'DASH=S�lido'#13+
'DOT=Tra�o'#13+
'DASH DOT=Ponto'#13+
'DASH DOT DOT=Tra�o Ponto'#13+
'CALCULATE EVERY=Calcula todo'#13+
'ALL POINTS=Todos ptos'#13+
'NUMBER OF POINTS=N�mero de pontos'#13+
'RANGE OF VALUES=Faixa de valores'#13+
'FIRST=Primeiro'#13+
'LAST=�ltimo'#13+
'TEEPREVIEW EDITOR=Editor TeePreview'#13+
'ALLOW MOVE=Permite Mover'#13+
'ALLOW RESIZE=Permite Redimens.'#13+
'DRAG IMAGE=Arrasta Imagem'#13+
'AS BITMAP=Como Bitmap'#13+
'SHOW IMAGE=Mostra Imagem'#13+
'MARGINS=Margens'#13+
'SIZE=Tam.'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Eleva��o'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Desl. Horiz.'#13+
'VERT. OFFSET=Desl. Vert.'#13+
'PERSPECTIVE=Perspectiva'#13+
'ANGLE=�ngulo'#13+
'ORTHOGONAL=Ortogonal'#13+
'ZOOM TEXT=Zoom Texto'#13+
'SCALES=Escalas'#13+
'TICKS=Marcas'#13+
'MINOR=Menor'#13+
'MAXIMUM=M�ximo'#13+
'MINIMUM=M�nimo'#13+
'(MAX)=(m�x)'#13+
'(MIN)=(m�n)'#13+
'DESIRED INCREMENT=Incr.Desejado'#13+
'(INCREMENT)=(incremento)'#13+
'LOG BASE=Base Log'#13+
'LOGARITHMIC=Logar�tmico'#13+
'MIN. SEPARATION %=% Separa��o M�n'#13+
'MULTI-LINE=Multi-linhas'#13+
'LABEL ON AXIS=R�tulo no Eixo'#13+
'ROUND FIRST=Redondo Primeiro'#13+
'MARK=Marca'#13+
'LABELS FORMAT=Formato R�tulos'#13+
'EXPONENTIAL=Exponencial'#13+
'DEFAULT ALIGNMENT=Alinhamento Padr�o'#13+
'LEN=Tam'#13+
'INNER=Dentro'#13+
'AT LABELS ONLY=S� nos R�tulos'#13+
'CENTERED=Centralizado'#13+
'POSITION %=% Posi��o'#13+
'START %=% In�cio'#13+
'END %=% Final'#13+
'OTHER SIDE=Outro lado'#13+
'AXES=Eixos'#13+
'BEHIND=Atr�s'#13+
'CLIP POINTS=Cortar Pontos'#13+
'PRINT PREVIEW=Vis. Impress�o'#13+
'STEPS=Passos'#13+
'MINIMUM PIXELS=Pixels M�nimo'#13+
'ALLOW=Permite'#13+
'ANIMATED=Animado'#13+
'ALLOW SCROLL=Permite Rolar'#13+
'TEEOPENGL EDITOR=Editor TeeOpenGL'#13+
'AMBIENT LIGHT=Luz Ambiente'#13+
'SHININESS=Brilho'#13+
'FONT 3D DEPTH=Prof. Fonte 3D'#13+
'ACTIVE=Ativo'#13+
'FONT OUTLINES=Contorno Fontes'#13+
'SMOOTH SHADING=Sombra Suave'#13+
'LIGHT=Luz'#13+
'Y=Y'#13+
'INTENSITY=Intensidade'#13+
'BEVEL=Borda'#13+
'FRAME=Borda'#13+
'ROUND FRAME=Borda Redonda'#13+
'LOWERED=Rebaixado'#13+
'RAISED=Elevado'#13+
'SYMBOLS=S�mbolos'#13+
'TEXT STYLE=Estilo Texto'#13+
'LEGEND STYLE=Estilo Legenda'#13+
'VERT. SPACING=Espa�o Vert.'#13+
'SERIES NAMES=Nomes S�ries'#13+
'SERIES VALUES=Valores S�ries'#13+
'LAST VALUES=�ltimos Valores'#13+
'PLAIN=Simples'#13+
'LEFT VALUE=Valor Esquerdo'#13+
'RIGHT VALUE=Valor Direito'#13+
'LEFT PERCENT=Percentual Esquerdo'#13+
'RIGHT PERCENT=Percentual Direito'#13+
'X VALUE=Valor X'#13+
'X AND VALUE=X e Valor'#13+
'X AND PERCENT=X e Percentual'#13+
'CHECK BOXES=Caixas checagem'#13+
'DIVIDING LINES=Linhas Divisoras'#13+
'FONT SERIES COLOR=Cor Fonte S�ries'#13+
'POSITION OFFSET %=Desl % Posi��o'#13+
'MARGIN=Margem'#13+
'RESIZE CHART=Redim.Gr�fico'#13+
'CONTINUOUS=Cont�nuo'#13+
'POINTS PER PAGE=Pontos por P�gina'#13+
'SCALE LAST PAGE=Escala �lt P�gina'#13+
'CURRENT PAGE LEGEND=Legenda p�g Atual'#13+
'PANEL EDITOR=Editor de Painel'#13+
'BACKGROUND=Fundo'#13+
'BORDERS=Bordas'#13

{$IFDEF LCL}
;  TeeBrazilLanguage.Text:=TeeBrazilLanguage.Text
{$ENDIF}

+
'BACK IMAGE=Imagem Fundo'#13+
'STRETCH=Ajusta'#13+
'TILE=Lado a Lado'#13+
'BEVEL INNER=Moldura Interna'#13+
'BEVEL OUTER=Moldura Externa'#13+
'MARKS=Marcas'#13+
'DATA SOURCE=Fonte de Dados'#13+
'SORT=Sortir'#13+
'CURSOR=Cursor'#13+
'SHOW IN LEGEND=Mostra na Legenda'#13+
'FORMATS=Formatos'#13+
'VALUES=Valores'#13+
'PERCENTS=Percento'#13+
'HORIZONTAL AXIS=Eixo Horizontal'#13+
'DATETIME=DataHora'#13+
'VERTICAL AXIS=Eixo Vertical'#13+
'ASCENDING=Ascendente'#13+
'DESCENDING=Descendente'#13+
'DRAW EVERY=Desenha cada'#13+
'CLIPPED=Cortado'#13+
'ARROWS=Setas'#13+
'LENGTH=Comprim.'#13+
'MULTI LINE=Multi linhas'#13+
'ALL SERIES VISIBLE=Todas S�ries Vis�veis'#13+
'LABEL=R�tulo'#13+
'LABEL AND PERCENT=R�tulo e Porcent.'#13+
'LABEL AND VALUE=R�tulo e Valor'#13+
'PERCENT TOTAL=Porcent.Total'#13+
'LABEL AND PERCENT TOTAL=R�tulo e Porcent.Total'#13+
'X AND Y VALUES=Valores X e Y'#13+
'MANUAL=Manual'#13+
'RANDOM=Aleat�rio'#13+
'FUNCTION=Fun��o'#13+
'NEW=Novo'#13+
'EDIT=Edita'#13+
'PERSISTENT=Persistente'#13+
'ADJUST FRAME=Ajusta Borda'#13+
'CENTER=Centr.'#13+
'SUBTITLE=SubT�tulo'#13+
'SUBFOOT=SubRodap�'#13+
'FOOT=Rodap�'#13+
'VISIBLE WALLS=Paredes Vis�veis'#13+
'BACK=Atr�s'#13+
'DIF. LIMIT=Limite Dif.'#13+
'ABOVE=Acima'#13+
'WITHIN=Dentro'#13+
'BELOW=Abaixo'#13+
'CONNECTING LINES=Linhas de Conex�o'#13+
'BROWSE=Visualiza'#13+
'TILED=Lado a Lado'#13+
'INFLATE MARGINS=Inflar Margens'#13+
'SQUARE=Quadrado'#13+
'DOWN TRIANGLE=Tri�ngulo Inv.'#13+
'SMALL DOT=Ponto Pequeno'#13+
'GLOBAL=Global'#13+
'SHAPES=Formas'#13+
'BRUSH=Broxa'#13+
'DELAY=Atraso'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=A��o Mouse'#13+
'MOVE=Move'#13+
'CLICK=Clica'#13+
'DRAW LINE=Desenha Linha'#13+
'EXPLODE BIGGEST=Explode maior'#13+
'TOTAL ANGLE=�ngulo Total'#13+
'GROUP SLICES=Agrupa fatias'#13+
'BELOW %=Abaixo %'#13+
'BELOW VALUE=Abaixo Valor'#13+
'OTHER=Outro'#13+
'PATTERNS=Padr�es'#13+
'HORIZ. SIZE=Tam. Horiz.'#13+
'VERT. SIZE=Tam. Vert.'#13+
'SIZE %=% Tam'#13+
'SERIES DATASOURCE TEXT EDITOR=Editor de fonte de dados da s�rie'#13+
'FIELDS=Campos'#13+
'NUMBER OF HEADER LINES=N�m.linhas Cabe�alho'#13+
'SEPARATOR=Separador'#13+
'COMMA=V�rgula'#13+
'SPACE=Espa�o'#13+
'TAB=Tab'#13+
'FILE=Arquivo'#13+
'WEB URL=URL Web'#13+
'LOAD=Carrega'#13+
'C LABELS=R�tulos C'#13+
'R LABELS=R�tulos R'#13+
'C PEN=Caneta C'#13+
'R PEN=Caneta R'#13+
'STACK GROUP=Empilha Grupo'#13+
'MULTIPLE BAR=Barras M�ltiplas'#13+
'SIDE=Lados'#13+
'SIDE ALL=Todos Lados'#13+
'DRAWING MODE=Modo Desenho'#13+
'WIREFRAME=Arame'#13+
'DOTFRAME=Pontos'#13+
'SMOOTH PALETTE=Paleta Suave'#13+
'SIDE BRUSH=Broxa Lateral'#13+
'ABOUT TEECHART PRO V7.0=Sobre TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Todos Direitos Reservados.'#13+
'VISIT OUR WEB SITE !=Visite nosso site !'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'SELECT A CHART STYLE=Escolha um estilo de Gr�fico'#13+
'DATABASE CHART=Gr�fico Banco de Dados'#13+
'NON DATABASE CHART=Gr�fico Sem Banco de Dados'#13+
'SELECT A DATABASE TABLE=Selecione uma Tabela'#13+
'ALIAS=Alias'#13+
'TABLE=Tabela'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Escolha os campos para Gr�fico'#13+
'SELECT A TEXT LABELS FIELD=Texto para r�tulos de Campo'#13+
'CHOOSE THE DESIRED CHART TYPE=Tipo de gr�fico desejado'#13+
'2D=2D'#13+
'CHART PREVIEW=Visualiza��o Gr�fico'#13+
'SHOW LEGEND=Mostra Legenda'#13+
'SHOW MARKS=Mostra Marcas'#13+
'< BACK=< Anterior'#13+
'EXPORT CHART=Exporta Gr�fico'#13+
'PICTURE=Figura'#13+
'NATIVE=Nativo'#13+
'KEEP ASPECT RATIO=Mant�m aspecto'#13+
'INCLUDE SERIES DATA=Inclui dados de S�ries'#13+
'FILE SIZE=Tamanho arquivo'#13+
'DELIMITER=Delimitador'#13+
'XML=XML'#13+
'HTML TABLE=Tabela HTML'#13+
'EXCEL=Excel'#13+
'COLON=Ponto e V�rgula'#13+
'INCLUDE=Inclui'#13+
'POINT LABELS=Pontos R�tulos'#13+
'POINT INDEX=Pontos Indice'#13+
'HEADER=Cabe�alho'#13+
'COPY=Copia'#13+
'SAVE=Salva'#13+
'SEND=Envia'#13+
'FUNCTIONS=Fun��es'#13+
'ADX=ADX'#13+
'AVERAGE=Bollinger'#13+
'BOLLINGER=Copia'#13+
'DIVIDE=Divide'#13+
'EXP. AVERAGE=M�dia Exp.'#13+
'EXP.MOV.AVRG.=M�dia M�vel Exp.'#13+
'MACD=MACD'#13+
'MOMENTUM=Momento'#13+
'MOMENTUM DIV=Div.Momento'#13+
'MOVING AVRG.=M�dia M�vel'#13+
'MULTIPLY=Multiplica'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Raiz Quad.M�dia'#13+
'STD.DEVIATION=Desvio Padr�o'#13+
'STOCHASTIC=Estoc�stico'#13+
'SUBTRACT=Subtrai'#13+
'SOURCE SERIES=S�rie Fonte'#13+
'TEECHART GALLERY=Galeria TeeChart'#13+
'DITHER=Difunde'#13+
'REDUCTION=Redu��o'#13+
'COMPRESSION=Compress�o'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Pr�ximo'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'GRAY SCALE=Escala Cinza'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantifica'#13+
'QUANTIZE 256=Quantifica 256'#13+
'% QUALITY=% Qualidade'#13+
'PERFORMANCE=Performance'#13+
'QUALITY=Qualidade'#13+
'SPEED=Velocidade'#13+
'COMPRESSION LEVEL=N�vel Compress�o'#13+
'CHART TOOLS GALLERY=Galeria Ferramentas Gr�fico'#13+
'ANNOTATION=Anota��o'#13+
'AXIS ARROWS=Cursor'#13+
'COLOR BAND=Desenha Linha'#13+
'COLOR LINE=Faixa Cores'#13+
'DRAG MARKS=Imagem'#13+
'MARK TIPS=Marcas Dicas'#13+
'NEAREST POINT=Ponto Pr�ximo'#13+
'ROTATE=Setas Eixo'#13+

// 6.0

'BEVEL SIZE=Tamanho borda'#13+
'DELETE ROW=Apaga linha'#13+
'VOLUME SERIES=Volume s�rie'#13+
'SINGLE=Simples'#13+
'REMOVE CUSTOM COLORS=Remove cores pers.'#13+
'USE PALETTE MINIMUM=Usa m�nimo paleta'#13+
'AXIS MAXIMUM=M�ximo de eixo'#13+
'AXIS CENTER=Centro de eixo'#13+
'AXIS MINIMUM=M�nimo de eixo'#13+
'DAILY (NONE)=Di�rio (nenhum)'#13+
'WEEKLY=Semanal'#13+
'MONTHLY=Mensal'#13+
'BI-MONTHLY=Bi-mensal'#13+
'QUARTERLY=Trimestral'#13+
'YEARLY=Anual'#13+
'DATETIME PERIOD=Per�odo datas/horas'#13+
'CASE SENSITIVE=Sens�vel a caixa'#13+
'DRAG STYLE=Estilo de arraste'#13+
'SQUARED=Quadrado'#13+
'GRID 3D SERIES=S�rie grade 3d'#13+
'DARK BORDER=Borda escura'#13+
'PIE SERIES=S�rie pizza'#13+
'FOCUS=Foco'#13+
'EXPLODE=Explode'#13+
'FACTOR=Fator'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Gr�fico a partir do modelo (arquivo *.tee)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Abre arquivo modelo teechart de'#13+
'BINARY=Bin�rio'#13+
'VOLUME OSCILLATOR=Oscilador de volume'#13+
'PIE SLICES=Fatias de pizza'#13+
'ARROW WIDTH=Comprimento seta'#13+
'ARROW HEIGHT=Altura seta'#13+
'DEFAULT COLOR=Cor padr�o'#13+
'OUTLINE GRADIENT=Gradiente contorno'#13+
'BALANCE=Balan�o'#13+
'RADIAL OFFSET=Desloc. Radial'#13+
'ROUND=Arredondado'#13+
'SHOW PAGE NUMBER=Mostra n�mero da p�gina'#13+
'COLOR EACH LINE=Colore cada linha'#13+
'POINTER=Ponteiro'#13+
'ARROW HEAD=Seta'#13+
'DISTANCE=Dist�ncia'#13+
'NUMBER OF SAMPLE VALUES=N�mero valores exemplo'#13+
'POINT COLORS=Cores de pontos'#13+
'PERIOD=Per�odo'#13+
'UP=Cima'#13+
'DOWN=Baixo'#13+
'SHADOW EDITOR=Editor de Sombra'#13+
'CALLOUT=Chamada Externa'#13+
'TEXT ALIGNMENT=Alinhamento Texto'#13+
'AVAILABLE LANGUAGES=Idiomas dispon�veis'#13+
'CHOOSE A LANGUAGE=Escolha um idioma'#13+
'CALCULATE USING=Calcula usando'#13+
'EVERY NUMBER OF POINTS=Cada n�mero de pontos'#13+
'EVERY RANGE=Cada faixa'#13+
'INCLUDE NULL VALUES=Inclui valores nulos'#13+
'INVERTED SCROLL=Relagem invertida'#13+
'DATE=Data'#13+
'ENTER DATE=Entre data'#13+
'ENTER TIME=Entre hora'#13+
'DEVIATION=Desvio'#13+
'UPPER=Superior'#13+
'LOWER=Inferior'#13+
'NOTHING=Nada'#13+
'LEFT TRIANGLE=Tri�ngulo esquerdo'#13+
'RIGHT TRIANGLE=Tri�ngulo direito'#13+
'CONSTANT=Constante'#13+
'SHOW LABELS=Mostra r�tulos'#13+
'SHOW COLORS=Mostra cores'#13+
'XYZ SERIES=S�ries XYZ'#13+
'SHOW X VALUES=Mostra valores Show X'#13+
'ACCUMULATE=Acumula'#13+
'STEP=Passo'#13+
'DRAG REPAINT=Repinta ao arrastar'#13+
'NO LIMIT DRAG=Sem limite de arraste'#13+
'SMOOTH=Suaviza'#13+
'INTERPOLATE=Interpola'#13+
'START X=X In�cio'#13+
'NUM. POINTS=Num. Pontos'#13+
'SORT BY=Classifica por'#13+
'(NONE)=(nenhum)'#13+
'CALCULATION=C�lculo'#13+
'GROUP=Grupo'#13+
'WEIGHT=Peso'#13+
'EDIT LEGEND=Edita Legenda'#13+
'FLAT=Liso'#13+
'DRAW ALL=Desenha todos'#13+
'IGNORE NULLS=Ignora nulos'#13+
'OFFSET=Desloc.'#13+
'Z %=Z %'#13+
'LIGHT 0=Luz 0'#13+
'LIGHT 1=Luz 1'#13+
'LIGHT 2=Luz 2'#13+
'DRAW STYLE=Estilo Desenho'#13+
'POINTS=Pontos'#13+
'DEFAULT BORDER=Borda padr�o'#13+
'SEPARATION=Separa��o'#13+
'ROUND BORDER=Borda arredondada'#13+
'RESIZE PIXELS TOLERANCE=Toler�ncia redim. pixels'#13+
'FULL REPAINT=Repinta tudo'#13+
'END POINT=Ponto final'#13+
'BAND 1=Faixa 1'#13+
'BAND 2=Faixa 2'#13+
'TRANSPOSE NOW=Transp�e agora'#13+
'PERIOD 1=Per�odo 1'#13+
'PERIOD 2=Per�odo 2'#13+
'PERIOD 3=Per�odo 3'#13+
'HISTOGRAM=Histograma'#13+
'EXP. LINE=Exp. Linha'#13+
'WEIGHTED=Ponderado'#13+
'WEIGHTED BY INDEX=Ponderado por �ndice'#13+
'BOX SIZE=Tamanho caixa'#13+
'REVERSAL AMOUNT=Qtde.Reversa'#13+
'PERCENTAGE=Percentagem'#13+
'COMPLETE R.M.S.=R.M.S.Completo'#13+
'BUTTON=Bot�o'#13+
'ALL=Todos'#13+
'START AT MIN. VALUE=Inicia no valor m�n.'#13+
'EXECUTE !=Executa !'#13+
'IMAG. SYMBOL=S�mbolo Imag.'#13+
'SELF STACK=Auto empilha'#13+
'SIDE LINES=Linhas de lado'#13+
'EXPORT DIALOG=Exportar Di�logo'#13+

// 7.0

'DRAG=Arraste'#13+
'HANDPOINT=Apontador'#13+
'HOURGLASS=Ampulheta'#13+
'SLANT CUBE=Cubo inclinado'#13+
'TICK LINES=Linhas grossas'#13+
'% BAR DEPTH=% Prof. barra'#13+
'METAL=Metal'#13+
'WOOD=Madeira'#13+
'STONE=Pedra'#13+
'CLOUDS=Nuvens'#13+
'GRASS=Grama'#13+
'FIRE=Fogo'#13+
'SNOW=Neve'#13+
'HIGH-LOW=Alto-Baixo'#13+
'VIEW SERIES NAMES=Visualiza nomes de s�ries'#13+
'EDIT COLOR=Editar cor'#13+
'MAKE NULL POINT=Criar ponto nulo'#13+
'APPEND ROW=Adicionar linha'#13+
'TEXT FONT=Fonte de texto'#13+
'CHART THEME SELECTOR=Seletor de temas de gr�ficos'#13+
'PREVIEW=Visualiza��o'#13+
'THEMES=Temas'#13+
'COLOR PALETTE=Paleta de cores'#13+
'VIEW 3D=Vista 3D'#13+
'SCALE=Escala'#13+
'MARGIN %=Margem %'#13+
'DRAW BEHIND AXES=Desenha atr�s eixos'#13+
'X GRID EVERY=Grade x a cada'#13+
'Z GRID EVERY=Grade Z a cada'#13+
'DATE PERIOD=Per�odo de datas'#13+
'TIME PERIOD=Per�odo de horas'#13+
'USE SERIES Z=Usa s�rie z'#13+
'NUMERIC FORMAT=Formato num�rico'#13+
'DATE TIME=Data hora'#13+
'GEOGRAPHIC=Geogr�fico'#13+
'DECIMALS=Decimais'#13+
'FIXED=Fixo'#13+
'THOUSANDS=Milhares'#13+
'CURRENCY=Moeda'#13+
'VIEWS=Vista='#13+
'ALTERNATE=Alternado'#13+
'ZOOM ON UP LEFT DRAG=Arrastando bot�o esq.'#13+
'FIXED POSITION=Posi��o fixa'#13+
'NO CHECK BOXES=Sem caixas de checagem'#13+
'RADIO BUTTONS=Bot�es de r�dio'#13+
'Z DATETIME=Z datahora'#13+
'SYMBOL=S�mbolo'#13+
'AUTO HIDE=Auto esconde'#13+
'GALLERY=Galeria'#13+
'INVERTED GRAY=Cinza invertido'#13+
'RAINBOW=Arco-�ris'#13+
'TEECHART LIGHTING=Ilumina��o TeeChart'#13+
'LINEAR=Linear'#13+
'SPOTLIGHT=Focalizada'#13+
'SHAPE INDEX=�ndice forma'#13+
'CLOSED=Fechado'#13+
'DESIGN TIME OPTIONS=Op��es de projeto'#13+
'LANGUAGE=Idioma'#13+
'CHART GALLERY=Galeria de gr�ficos'#13+
'MODE=Modo'#13+
'CHART EDITOR=Editor gr�fico'#13+
'REMEMBER SIZE=Lembra tamanho'#13+
'REMEMBER POSITION=Lembra posi��o'#13+
'TREE MODE=Modo �rvore'#13+
'RESET=Reinicializa'#13+
'NEW CHART=Novo gr�fico'#13+
'DEFAULT THEME=Tema padr�o'#13+
'TEECHART DEFAULT=Padr�o TeeChart'#13+
'CLASSIC=Cl�ssico'#13+
'BUSINESS=Neg�cio'#13+
'WEB=WEB'#13+
'WINDOWS XP=Windows XP'#13+
'BLUES=AZUIS'#13+
'MULTIPLE PIES=M�ltiplas pizzas'#13+
'3D GRADIENT=Gradiente 3D'#13+
'DISABLE=Desabilita'#13+
'COLOR EACH SLICE=Colore cada fatia'#13+
'BASE LINE=Linha de base'#13+
'INITIAL DELAY=Demora inicial'#13+
'THUMB=Polegar'#13+
'AUTO-REPEAT=Auto-repete'#13+
'BACK COLOR=Cor de fundo'#13+
'HANDLES=Manipuladores'#13+
'ALLOW RESIZE CHART=Permite redimensionar gr�fico'#13+
'LOOP=Loop'#13+
'ONE WAY=M�O �NICA'#13+
'DRAW BEHIND SERIES=Desenha atr�s s�ries'#13+
'SURFACE=SUPERF�CIE'#13+
'CELL=C�LULA'#13+
'ROW=Linha'#13+
'COLUMN=Coluna'#13+
'FAST BRUSH=Pincel r�pido'#13+
'SVG OPTIONS=Op��es SVG'#13+
'TEXT ANTI-ALIAS=Texto anti-alias'#13+
'THEME=Tema'#13+
'TEXT QUOTES=Nota��es de texto'#13+
'PERIMETER=Per�metro'#13+
'ACE=�s'#13+
'CARIBE SUN=Sol Caribenho'#13+
'CLEAR DAY=Dia limpo'#13+
'DESERT=Deserto'#13+
'FARM=Fazenda'#13+
'FUNKY=Esquisito'#13+
'GOLF=Golfe'#13+
'HOT=Quente'#13+
'NIGHT=Noite'#13+
'PASTEL=Pastel'#13+
'SEA=Mar'#13+
'SEA 2=Mar 2'#13+
'SUNSET=Por do sol'#13+
'TROPICAL=Tropical'#13+
'RADIAL=Radial'#13+
'DIAGONAL UP=Diagonal cima'#13+
'DIAGONAL DOWN=Diagonal baixo'#13+
'CLIP SERIES=Trunca s�ries'#13+
'SERIES BAND=Faixa de s�rie'#13+
'SURFACE NEAREST=Superf�cie pr�xima'#13+
'COVER=COBERTURA='#13+
'HIDE TRIANGLES=Esconde tri�ngulos'#13+
'MIRRORED=Espelhado'#13+
'VALUE SOURCE=Valor fonte'
;

  end;
end;

Procedure TeeSetBrazil;
begin
  TeeCreateBrazil;
  TeeLanguage:=TeeBrazilLanguage;
  TeeBrazilConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeBrazilLanguage);
end.
