{**********************************************}
{   TTree Component Library.                   }
{   String constants.                          }
{   Copyright (c) 1998-2009 by David Berneda   }
{**********************************************}
{$I TeeDefs.inc}
unit TreeConst;

interface

var
  TreeMsg_Browse,
  TreeMsg_Clear,
  TeeMsg_TreeCopyright,
  TeeMsg_TreePrintPreview,
  TeeMsg_TreeExportChart,
  TeeMsg_TreeAbout,
  TeeMsg_TreeLoad,
  TeeMsg_TreeFiles,
  TeeMsg_TreeEdit,
  TeeMsg_TreeSureDelete,
  TreeMsg_Connection,
  TreeMsg_CannotSetShape,
  TreeMsg_Editing,

  TreeMsg_Child,
  TreeMsg_Root,
  TreeMsg_ExportTree,
  TreeMsg_SureToNew,
  TreeMsg_SearchNode,
  TreeMsg_NodeText,
  TreeMsg_ClickTwoShapes,
  TreeMsg_About,
  TreeMsg_EditingMode,

  { DBTree }
  TreeMsg_DBCodeNeeded,
  TreeMsg_DBTextNeeded,
  TreeMsg_SureToCancel,
  TreeMsg_MasterNeed,
  TreeMsg_DetailNeed,
  TreeMsg_GroupField,
  TreeMsg_ParentField,
  TreeMsg_MasterFields,
  TreeMsg_TextFields,
  TreeMsg_MasterDataset,
  TreeMsg_DataSet,

  TreeMsg_DBFieldNotFound,
  TeeMsg_TreeDBRefresh,
  TeeMsg_TreeDBWizard,
  TreeMsg_OneTextField,
  TreeMsg_OneDetailField,
  TreeMsg_OneParentField,
  TreeMsg_Finish,
  TreeMsg_Next,
  TreeMsg_TreeEditor,

  { Shape tabs }
  TeeTree_tabFlow,
  TeeTree_tabOther,
  TeeTree_tabElectric,
  TeeTree_tabUML,
  TeeTree_tabTransit,

  TreeMsg_EditorTips,

  TreeMsg_Caps,
  TreeMsg_Num,
  TreeMsg_SCR,

  TreeMsg_ImportTextFile,
  TreeMsg_Point,
  TreeMsg_TreeNil

   : String;

Const
  TeeMsg_TeeTreePalette  = 'TeeTree';
  TeeTree_MajorVersion   = '2';
  TeeTree_MinorVersion   = '.0';
  TreeMsg_TeeTree        = 'TeeTree v'+TeeTree_MajorVersion+TeeTree_MinorVersion;
  TreeMsg_CompNamePrefix = 'TreeShape';
  TreeMsg_TeeExtension   = 'ttr';
  TreeMsg_SteemaWWW      = 'http://www.steema.com';
  TeeTreeKey             = '\Software\Steema Software\TeeTree Office';
  TreeMsg_Tree1          = 'Tree1';
  TeeMsg_Modified        = 'Modified';

Procedure TreeSetEnglishConstants;
Procedure TreeSetEnglish;

Procedure TreeSetLanguage(English:Boolean);
Procedure TreeLanguageHook;

Procedure TreeSetBrazil;
Procedure TreeSetCatalan;
Procedure TreeSetChinese;
Procedure TreeSetChineseSimp;
Procedure TreeSetDanish;
Procedure TreeSetDutch;
Procedure TreeSetFrench;
Procedure TreeSetGalician;
Procedure TreeSetGerman;
Procedure TreeSetHungarian;
Procedure TreeSetItalian;
Procedure TreeSetJapanese;
Procedure TreeSetNorwegian;
Procedure TreeSetPolish;
Procedure TreeSetPortuguese;
Procedure TreeSetRussian;
Procedure TreeSetSlovene;
Procedure TreeSetSpanish;
Procedure TreeSetSwedish;
Procedure TreeSetTurkish;

implementation

Uses TeeCatalan, TeeSpanish, TeeGerman, TeeFrench, TeeBrazil, TeeDanish,
     TeeDutch, TeeSwedish, TeeChinese, TeeChineseSimp, TeePortuguese,
     TeeHungarian, TeeRussian, TeeItalian, TeeNorwegian, TeeJapanese,
     TeePolish, TeeSlovene, TeeTurkish, TeeGalician,
     TeeConst, TeeOfficeConstants, TeeTranslate;

Procedure TreeSetLanguage(English:Boolean);
begin
  Case TeeLanguageRegistry of
    1: TreeSetBrazil;
    2: TreeSetCatalan;
    3: TreeSetChineseSimp;
    4: TreeSetChinese;
    5: TreeSetDanish;
    6: TreeSetDutch;
    7: TreeSetFrench;
    8: TreeSetGerman;
    9: TreeSetItalian;
   10: TreeSetPortuguese;
   11: TreeSetRussian;
   12: TreeSetSpanish;
   13: TreeSetSwedish;
   14: TreeSetNorwegian;
   15: TreeSetJapanese;
   16: TreeSetPolish;
   17: TreeSetSlovene;
   18: TreeSetTurkish;
   19: TreeSetHungarian;
   20: TreeSetGalician;
  else
    if English then TreeSetEnglish;
  end;
end;

Procedure TreeLanguageHook;
begin
  if TeeAskLanguage then TreeSetLanguage(True);
end;

Procedure TreeSetEnglishConstants;
begin
  TreeMsg_Browse         := '&Browse Back Image...';
  TreeMsg_Clear          := 'C&lear Back Image';

  TeeMsg_TreeCopyright    := '© 1998-2006 by David Berneda';
  TeeMsg_TreePrintPreview := '&Print Preview...';
  TeeMsg_TreeExportChart  := 'E&xport Tree...';
  TeeMsg_TreeAbout        := '&About TeeTree...';
  TeeMsg_TreeLoad         := '&Load Tree...';
  TeeMsg_TreeFiles        := 'TeeTree v'+TeeTree_MajorVersion+' files (*.ttr)|*.ttr';
  TeeMsg_TreeEdit         := 'E&dit Tree...';
  TeeMsg_TreeSureDelete   := 'Sure to Delete Nodes?';
  TreeMsg_Connection      := 'Connection';
  TreeMsg_CannotSetShape  := 'Use the Tree property. Shapes property is read-only';
  TreeMsg_Editing         := 'Editing %s';

  TreeMsg_Child           := 'Child';
  TreeMsg_Root            := 'Root';
  TreeMsg_ExportTree      := 'Export Tree';
  TreeMsg_SureToNew       := 'Sure to clear the current Tree? Warning: It cannot be undone';
  TreeMsg_SearchNode      := 'Search Nodes with...';
  TreeMsg_NodeText        := 'Text:';
  TreeMsg_ClickTwoShapes  := 'Click two nodes to connect them. Press ESC to cancel.';

  TreeMsg_About           := 'About %s...';

  TreeMsg_EditingMode     := 'Editing node: ';

  { DBTree }
  TreeMsg_DBCodeNeeded := 'Code, Parent and Text fields should be selected';
  TreeMsg_DBTextNeeded := 'Text fields should be selected';
  TreeMsg_SureToCancel := 'Sure to Cancel changes?';
  TreeMsg_MasterNeed   := 'Master fields should be selected';
  TreeMsg_DetailNeed   := 'Detail fields should be selected';

  TreeMsg_GroupField   := '&Group field:';
  TreeMsg_ParentField  := '&Parent field:';
  TreeMsg_MasterFields := 'Master fields:';
  TreeMsg_TextFields   := '&Text fields:';
  TreeMsg_MasterDataset:= 'Master Dataset:';
  TreeMsg_DataSet      := '&Dataset:';

  TreeMsg_DBFieldNotFound := 'Field %s not found in table %s';
  TeeMsg_TreeDBRefresh    := 'Refresh DataSet';
  TeeMsg_TreeDBWizard     := 'Database Wizard...';
  TreeMsg_OneTextField    := 'At least one Text field should be selected.';
  TreeMsg_OneDetailField  := 'At least one Detail field should be selected.';
  TreeMsg_OneParentField  := 'The Parent field should be selected.';

  TreeMsg_Finish       := '&Finish';
  TreeMsg_Next         := '&Next >';

  TreeMsg_TreeEditor     := 'Tree Editor';

  { Shape tabs }
  TeeTree_tabFlow        :='FlowChart';
  TeeTree_tabElectric    :='Electric';
  TeeTree_tabOther       :='Other';
  TeeTree_tabUML         :='UML';
  TeeTree_tabTransit     :='Transit';

  TreeMsg_EditorTips   := 'TeeTree Editor Tips:'+#13+#13+
   'RIGHT click a shape or connection to show the POPUP MENU'+#13+
   'DOUBLE click a shape with LEFT mouse button to EDIT it'+#13+#13+
   'Shape selection:'+#13+
   'CLICK a shape to SELECT it'+#13+
   ' Press SHIFT key and click a shape to MULTISELECT shapes'+#13+
   ' Press CTRL key and click a shape to multiselect CHILDS too'+#13+#13+
   'RIGHT click the panel and DRAG the mouse to SCROLL'+#13+
   'With LEFT mouse, select a RECTANGLE to multi-select shapes'+#13+#13+
   'Use keyboard arrows and CTRL and SHIFT to move / resize shapes'+#13+
   'Press DELETE key to DELETE selected shapes'+#13+#13+
   'Click a Connection to SELECT it';

  TreeMsg_Caps :='CAPS';
  TreeMsg_Num  :='NUM';
  TreeMsg_SCR  :='SCR';
  TreeMsg_ImportTextFile:='Import Tree nodes from text file';
  TreeMsg_Point:='Point';

  TreeMsg_TreeNil := 'Tree property should be assigned.';
end;

Procedure TreeSetEnglish;
begin
  TreeSetEnglishConstants;

  TeeLanguage:=TeeEnglishLanguage;
  TeeSetConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

Procedure TreeSetSpanish;

Procedure SetSpanishConstants;
begin
  TreeMsg_Browse         := '&Abrir Imagen...';
  TreeMsg_Clear          := '&Quitar Imagen';

  TeeMsg_TreeCopyright    := '© 1998-2006 por David Berneda';
  TeeMsg_TreePrintPreview := '&Vista Preliminar...';
  TeeMsg_TreeExportChart  := 'E&xportar Tree...';
  TeeMsg_TreeAbout        := '&Acerca de TeeTree...';
  TeeMsg_TreeLoad         := '&Abrir TeeTree...';
  TeeMsg_TreeFiles        := 'Archivos TeeTree v'+TeeTree_MajorVersion+' (*.ttr)|*.ttr';
  TeeMsg_TreeEdit         := 'E&ditar Tree...';
  TeeMsg_TreeSureDelete   := '¿Seguro que deseas eliminar los nodos?';
  TreeMsg_Connection      := 'Conexión';
  TreeMsg_CannotSetShape  := 'Usa la propiedad Tree. La propiedad Shapes es de sólo lectura.';
  TreeMsg_Editing         := 'Editando %s';

  TreeMsg_Child           := 'Hijo';
  TreeMsg_Root            := 'Raíz';
  TreeMsg_ExportTree      := 'Exportar Tree';
  TreeMsg_SureToNew       := '¿Seguro que desea borrar el diagrama? Cuidado: No se puede deshacer el borrado.';
  TreeMsg_SearchNode      := 'Buscar nodos con...';
  TreeMsg_NodeText        := 'Texto:';
  TreeMsg_ClickTwoShapes  := 'Cliquea dos nodos para conectarlos. Pulsa ESCAPE para cancelar.';

  TreeMsg_About           := 'Acerca de %s...';

  TreeMsg_EditingMode     := 'Editando nodo: ';

  { DBTree }
  TreeMsg_DBCodeNeeded := 'Los campos Código, Padre y Texto deben ser seleccionados.';
  TreeMsg_DBTextNeeded := 'Los campos Texto deben ser seleccionados.';
  TreeMsg_SureToCancel := '¿Seguro que deseas cancelar los cambios?';
  TreeMsg_MasterNeed   := 'Los campos Master deben ser seleccionados';
  TreeMsg_DetailNeed   := 'Los campos Detalle deben ser seleccionados';

  TreeMsg_GroupField   := 'Campo &Grupo:';
  TreeMsg_ParentField  := 'Campo &Padre:';
  TreeMsg_MasterFields := 'Campos Master:';
  TreeMsg_TextFields   := 'Campos &Texto:';
  TreeMsg_MasterDataset:= 'Tabla Master:';
  TreeMsg_DataSet      := '&Tabla:';

  TreeMsg_DBFieldNotFound := 'El campo %s no se encuentra en la tabla %s';
  TeeMsg_TreeDBRefresh    := 'Refrescar Tabla';
  TeeMsg_TreeDBWizard     := 'Asistente Base de Datos...';
  TreeMsg_OneTextField    := 'Al menos un campo de Texto debe ser seleccionado.';
  TreeMsg_OneDetailField  := 'Al menos un campo de Detalle debe ser seleccionado.';
  TreeMsg_OneParentField  := 'El campo Padre debe ser seleccionado.';

  TreeMsg_Finish       := '&Terminar';
  TreeMsg_Next         := '&Siguiente >';

  TreeMsg_TreeEditor     := 'Editor TeeTree';

  { Shape tabs }
  TeeTree_tabFlow        :='Diagramas';
  TeeTree_tabElectric    :='Electricas';
  TeeTree_tabOther       :='Otras';
  TeeTree_tabTransit     :='Tráfico';

  TreeMsg_EditorTips   := 'Ayuda del editor TeeTree:'+#13+#13+
   'Cliquea un nodo con botón DERECHO para mostrar el menú del nodo.'+#13+
   'DOBLE click un nodo con botón IZQUIERDO para editar el nodo.'+#13+#13+
   'Selección de nodos:'+#13+
   'CLIQUEA un nodo para seleccionarlo.'+#13+
   ' Pulsa la tecla MAYU (shift) y cliquea nodos para selección múltiple.'+#13+
   ' Pulsa la tecla CONTROL (ctrl) y cliquea un nodo para seleccionar tambien sus hijos.'+#13+#13+
   'Desplaza el ratón con botón DERECHO en el panel para desplazamiento.'+#13+
   'Con botón IZQUIERDO dibuja un rectángulo para seleccionar los nodos que hay dentro.'+#13+#13+
   'Usa las teclas de flechas con CONTROL y MAYU (shift) para mover / redimensionar.'+#13+
   'Pulsa la tecla SUPRIMIR para borrar los nodos seleccionados.'+#13+#13+
   'Cliquea una conexión para seleccionarla.';

  TreeMsg_Caps            :='MAYU';
  TreeMsg_Num             :='NUM';
  TreeMsg_SCR             :='DES';

  TreeMsg_ImportTextFile  :='Importar nodos desde archivo de texto';
  TreeMsg_Point:='Punto';
  TreeMsg_TreeNil := 'La propiedad Tree está vacia.';
end;

begin
  SetSpanishConstants;
  TeeSetSpanish;

  with TeeSpanishLanguage do
  if IndexOfName('FLOWCHART')=-1 then
    Text:=Text+#13+
    'FLOWCHART=Diagramas'#13+
    'INSERT=Insertar'#13+
    'NODES=Nodos'#13+
    'DESIGN=Diseño'#13+
    'PREVIEW=Navegación'#13+
    'ABOUT TEETREE=Acerca de TeeTree'#13+
    'EDITOR TIPS=Uso del Editor'#13+
    'TEETREE WEB SITE=Sitio web de TeeTree'#13+
    'LINK NODES=Unir nodos'#13+
    'PRUNE NODES=Desconectar nodos'#13+
    'CLIP TEXT=Ocultar texto'#13+
    'SHADOW COLOR=Color de Sombra'#13+
    'NEW CHILD=Añadir hijo'#13+
    'NEW BROTHER=Añadir hermano'#13+
    'NEW ROOT=Añadir nodo raiz'#13+
    'NEW PARENT=Añadir padre'#13+
    'CONNECTIONS=Conexiones'#13+
    'IMAGES=Imágenes'#13+
    'CROSS BOXES=Casillas expansión'#13+
    'EDITOR TABS=Pantallas editor'#13+
    'SHAPE TABS=Formas de nodos'#13+
    'RULERS=Guias'#13+
    'TOOLBAR=Barra herramientas'#13+
    'FONT TOOLBAR=Barra fuente'#13+
    'BORDER TOOLBAR=Barra formato'#13+
    'NODE TREE=Arbol de nodos'#13+
    'CUT=Cortar'#13+
    'PASTE=Pegar'#13+
    'SEARCH=Buscar nodos'#13+
    'ALIGN TO GRID=Alinear a rejilla'#13+
    'IMPORT=Importar'#13+
    'NEW TREE=Nuevo Diagrama'#13+
    'PRINT TREE=Imprimir Diagrama'#13+
    'ZOOM IN=Acercar'#13+
    'ZOOM OUT=Alejar'#13+
    'CONNECT NODES=Conectar nodos'#13+
    'ADD CHILD=Añadir hijo'#13+
    'ADD BROTHER=Añadir hermano'#13+
    'PRUNE=Desconectar'#13+
    'BRING TO FRONT=Mover al frente'#13+
    'SEND TO BACK=Mover al fondo'#13+
    'ADD NEW ROOT=Añadir nuevo nodo raiz'#13+
    'SHOW NAMES=Ver Nombres'#13+
    'ALIGN TO LEFT=Alinear a la izquierda'#13+
    'AUTO SCROLL=Desplaz. Automático'#13+
    'BORDER STYLE=Estilo lápiz'#13+
    'BORDER COLOR=Color lápiz'#13+
    'BORDER WIDTH=Ancho lápiz'#13+
    'DESIGN MODE=Modo Diseño'#13+
    'BUFFERED DISPLAY=Sin parpadeo'#13+
    'PRINT PANEL=Imprimir Panel'#13+
    'ZOOM FROM CENTER=Zoom desde centro'#13+
    'CROSS BOX=Casillas'#13+
    'SIGN PEN=Lápiz signo'#13+
    'MODE=Modo'#13+
    'STRETCHED=Ajustado'#13+
    'ALIGN=Alinear'#13+
    'MOUSE=Ratón'#13+
    'ALLOW ZOOM=Permitir Zoom'#13+
    'HOTTRACK=Seguimiento'#13+
    'MOUSE WHEEL=Rueda del ratón'#13+
    'SELECT NODES=Seleccionar nodos'#13+
    'SCROLL VERT.=Desplaz. Vert.'#13+
    'SCROLL HORIZ.=Desplaz. Horiz.'#13+
    'TEXT COLOR=Color Texto'#13+
    'SCROLL TO VIEW=Hacer visible'#13+
    'UNFOCUSED COLOR=Color sin foco'#13+
    'UNFOCUSED BORDER=Borde sin foco'#13+
    'ALLOW DELETE=Permite borrar'#13+
    'SINGLE SELECTION=Selección única'#13+
    'SCROLL BARS=Barras Desplaz.'#13+
    'GRID VISIBLE=Ver Rejilla'#13+
    'SNAP TO GRID=Ajuste a rejilla'#13+
    'SHOW RULERS=Ver guias'#13+
    'INTERCHAR SPACING=Espaciado'#13+
    'VERT. ALIGN=Alinear Vert.'#13+
    'ARROW FROM=Flecha desde'#13+
    'ARROW TO=Flecha hasta'#13+
    'SIDES=Lados'#13+
    'CURVE=Curva'#13+
    'CHILDREN CONNECTIONS=Conexiones'#13+
    'CROSS-BOX=Casilla'#13+
    'HORIZONTAL ALIGNMENT=Alinear Horiz.'#13+
    'DEFAULT IMAGE=Imagen defecto'#13+
    'HORIZONTAL SIZE=Tamaño Horiz.'#13+
    'VERTICAL SIZE=Tamaño Vert.'#13+
    'MOVE HORIZ=Mover horiz.'#13+
    'MOVE VERT=Mover vert.'#13+
    'EDIT CONNECTION=Editar Conexión'#13+
    'DELETE CONNECTION=Borrar Conexión'#13+
    'ADD NEW POINT=Añadir Punto'#13+
    'DELETE POINT=Eliminar Punto'#13+
    'FIXED=Fijo'#13+
    'ELECTRIC=Eléctricas'#13+
    'DURATION=Duración'#13+
    'ENABLED=Activado'#13+
    'NODE=Nodo'#13+
    'PLAY=Reproducir'#13+
    'PAUSE=Pausar'#13+
    'STOP=Parar'#13+
    'LOOP=Bucle'#13+
    'ANIMATIONS=Animaciones'#13+
    'ADD ANIMATION=Añadir animación'#13+
    'NEXT FRAME=Siguiente fotograma'#13+
    'COPY AS PICTURE=Copiar como imagen'#13+
    'NEW DATABASE TREE=Nuevo árbol desde Base de Datos'#13+
    'ANIMATION=Animación'#13+
    'SPACING=Espaciado'#13+
    'SIZE TO GRID=Tamaño a rejilla'#13+
    'CLIP=Ocultar'#13+
    'POLYGON=Polígono'#13+
    'POLYLINE=Poli-linea'#13+
    'TRANSIT=Tráfico'#13+
    'BUILD=ver';
end;

Procedure TreeSetGalician;

Procedure SetGalicianConstants;
begin
  TreeMsg_Browse         := '&Abrir Imagen...';
  TreeMsg_Clear          := '&Quitar Imagen';

  TeeMsg_TreeCopyright    := '© 1998-2006 por David Berneda';
  TeeMsg_TreePrintPreview := '&Vista Preliminar...';
  TeeMsg_TreeExportChart  := 'E&xportar Tree...';
  TeeMsg_TreeAbout        := '&Acerca de TeeTree...';
  TeeMsg_TreeLoad         := '&Abrir TeeTree...';
  TeeMsg_TreeFiles        := 'Archivos TeeTree v'+TeeTree_MajorVersion+' (*.ttr)|*.ttr';
  TeeMsg_TreeEdit         := 'E&ditar Tree...';
  TeeMsg_TreeSureDelete   := '¿Seguro que deseas eliminar los nodos?';
  TreeMsg_Connection      := 'Conexión';
  TreeMsg_CannotSetShape  := 'Usa la propiedad Tree. La propiedad Shapes es de sólo lectura.';
  TreeMsg_Editing         := 'Editando %s';

  TreeMsg_Child           := 'Hijo';
  TreeMsg_Root            := 'Raíz';
  TreeMsg_ExportTree      := 'Exportar Tree';
  TreeMsg_SureToNew       := '¿Seguro que desea borrar el diagrama? Cuidado: No se puede deshacer el borrado.';
  TreeMsg_SearchNode      := 'Buscar nodos con...';
  TreeMsg_NodeText        := 'Texto:';
  TreeMsg_ClickTwoShapes  := 'Cliquea dos nodos para conectarlos. Pulsa ESCAPE para cancelar.';

  TreeMsg_About           := 'Acerca de %s...';

  TreeMsg_EditingMode     := 'Editando nodo: ';

  { DBTree }
  TreeMsg_DBCodeNeeded := 'Los campos Código, Padre y Texto deben ser seleccionados.';
  TreeMsg_DBTextNeeded := 'Los campos Texto deben ser seleccionados.';
  TreeMsg_SureToCancel := '¿Seguro que deseas cancelar los cambios?';
  TreeMsg_MasterNeed   := 'Los campos Master deben ser seleccionados';
  TreeMsg_DetailNeed   := 'Los campos Detalle deben ser seleccionados';

  TreeMsg_GroupField   := 'Campo &Grupo:';
  TreeMsg_ParentField  := 'Campo &Padre:';
  TreeMsg_MasterFields := 'Campos Master:';
  TreeMsg_TextFields   := 'Campos &Texto:';
  TreeMsg_MasterDataset:= 'Tabla Master:';
  TreeMsg_DataSet      := '&Tabla:';

  TreeMsg_DBFieldNotFound := 'El campo %s no se encuentra en la tabla %s';
  TeeMsg_TreeDBRefresh    := 'Refrescar Tabla';
  TeeMsg_TreeDBWizard     := 'Asistente Base de Datos...';
  TreeMsg_OneTextField    := 'Al menos un campo de Texto debe ser seleccionado.';
  TreeMsg_OneDetailField  := 'Al menos un campo de Detalle debe ser seleccionado.';
  TreeMsg_OneParentField  := 'El campo Padre debe ser seleccionado.';

  TreeMsg_Finish       := '&Terminar';
  TreeMsg_Next         := '&Siguiente >';

  TreeMsg_TreeEditor     := 'Editor TeeTree';

  { Shape tabs }
  TeeTree_tabFlow        :='Diagramas';
  TeeTree_tabElectric    :='Electricas';
  TeeTree_tabOther       :='Otras';
  TeeTree_tabTransit     :='Tráfico';

  TreeMsg_EditorTips   := 'Ayuda del editor TeeTree:'+#13+#13+
   'Cliquea un nodo con botón DERECHO para mostrar el menú del nodo.'+#13+
   'DOBLE click un nodo con botón IZQUIERDO para editar el nodo.'+#13+#13+
   'Selección de nodos:'+#13+
   'CLIQUEA un nodo para seleccionarlo.'+#13+
   ' Pulsa la tecla MAYU (shift) y cliquea nodos para selección múltiple.'+#13+
   ' Pulsa la tecla CONTROL (ctrl) y cliquea un nodo para seleccionar tambien sus hijos.'+#13+#13+
   'Desplaza el ratón con botón DERECHO en el panel para desplazamiento.'+#13+
   'Con botón IZQUIERDO dibuja un rectángulo para seleccionar los nodos que hay dentro.'+#13+#13+
   'Usa las teclas de flechas con CONTROL y MAYU (shift) para mover / redimensionar.'+#13+
   'Pulsa la tecla SUPRIMIR para borrar los nodos seleccionados.'+#13+#13+
   'Cliquea una conexión para seleccionarla.';

  TreeMsg_Caps            :='MAYU';
  TreeMsg_Num             :='NUM';
  TreeMsg_SCR             :='DES';

  TreeMsg_ImportTextFile  :='Importar nodos desde archivo de texto';
  TreeMsg_Point:='Punto';
  TreeMsg_TreeNil := 'La propiedad Tree está vacia.';
end;

begin
  SetGalicianConstants;
  TeeSetGalician;

  with TeeGalicianLanguage do
  if IndexOfName('FLOWCHART')=-1 then
    Text:=Text+#13+
    'FLOWCHART=Diagramas'#13+
    'INSERT=Insertar'#13+
    'NODES=Nodos'#13+
    'DESIGN=Diseño'#13+
    'PREVIEW=Navegación'#13+
    'ABOUT TEETREE=Acerca de TeeTree'#13+
    'EDITOR TIPS=Uso del Editor'#13+
    'TEETREE WEB SITE=Sitio web de TeeTree'#13+
    'LINK NODES=Unir nodos'#13+
    'PRUNE NODES=Desconectar nodos'#13+
    'CLIP TEXT=Ocultar texto'#13+
    'SHADOW COLOR=Color de Sombra'#13+
    'NEW CHILD=Añadir hijo'#13+
    'NEW BROTHER=Añadir hermano'#13+
    'NEW ROOT=Añadir nodo raiz'#13+
    'NEW PARENT=Añadir padre'#13+
    'CONNECTIONS=Conexiones'#13+
    'IMAGES=Imágenes'#13+
    'CROSS BOXES=Casillas expansión'#13+
    'EDITOR TABS=Pantallas editor'#13+
    'SHAPE TABS=Formas de nodos'#13+
    'RULERS=Guias'#13+
    'TOOLBAR=Barra herramientas'#13+
    'FONT TOOLBAR=Barra fuente'#13+
    'BORDER TOOLBAR=Barra formato'#13+
    'NODE TREE=Arbol de nodos'#13+
    'CUT=Cortar'#13+
    'PASTE=Pegar'#13+
    'SEARCH=Buscar nodos'#13+
    'ALIGN TO GRID=Alinear a rejilla'#13+
    'IMPORT=Importar'#13+
    'NEW TREE=Nuevo Diagrama'#13+
    'PRINT TREE=Imprimir Diagrama'#13+
    'ZOOM IN=Acercar'#13+
    'ZOOM OUT=Alejar'#13+
    'CONNECT NODES=Conectar nodos'#13+
    'ADD CHILD=Añadir hijo'#13+
    'ADD BROTHER=Añadir hermano'#13+
    'PRUNE=Desconectar'#13+
    'BRING TO FRONT=Mover al frente'#13+
    'SEND TO BACK=Mover al fondo'#13+
    'ADD NEW ROOT=Añadir nuevo nodo raiz'#13+
    'SHOW NAMES=Ver Nombres'#13+
    'ALIGN TO LEFT=Alinear a la izquierda'#13+
    'AUTO SCROLL=Desplaz. Automático'#13+
    'BORDER STYLE=Estilo lápiz'#13+
    'BORDER COLOR=Color lápiz'#13+
    'BORDER WIDTH=Ancho lápiz'#13+
    'DESIGN MODE=Modo Diseño'#13+
    'BUFFERED DISPLAY=Sin parpadeo'#13+
    'PRINT PANEL=Imprimir Panel'#13+
    'ZOOM FROM CENTER=Zoom desde centro'#13+
    'CROSS BOX=Casillas'#13+
    'SIGN PEN=Lápiz signo'#13+
    'MODE=Modo'#13+
    'STRETCHED=Ajustado'#13+
    'ALIGN=Alinear'#13+
    'MOUSE=Ratón'#13+
    'ALLOW ZOOM=Permitir Zoom'#13+
    'HOTTRACK=Seguimiento'#13+
    'MOUSE WHEEL=Rueda del ratón'#13+
    'SELECT NODES=Seleccionar nodos'#13+
    'SCROLL VERT.=Desplaz. Vert.'#13+
    'SCROLL HORIZ.=Desplaz. Horiz.'#13+
    'TEXT COLOR=Color Texto'#13+
    'SCROLL TO VIEW=Hacer visible'#13+
    'UNFOCUSED COLOR=Color sin foco'#13+
    'UNFOCUSED BORDER=Borde sin foco'#13+
    'ALLOW DELETE=Permite borrar'#13+
    'SINGLE SELECTION=Selección única'#13+
    'SCROLL BARS=Barras Desplaz.'#13+
    'GRID VISIBLE=Ver Rejilla'#13+
    'SNAP TO GRID=Ajuste a rejilla'#13+
    'SHOW RULERS=Ver guias'#13+
    'INTERCHAR SPACING=Espaciado'#13+
    'VERT. ALIGN=Alinear Vert.'#13+
    'ARROW FROM=Flecha desde'#13+
    'ARROW TO=Flecha hasta'#13+
    'SIDES=Lados'#13+
    'CURVE=Curva'#13+
    'CHILDREN CONNECTIONS=Conexiones'#13+
    'CROSS-BOX=Casilla'#13+
    'HORIZONTAL ALIGNMENT=Alinear Horiz.'#13+
    'DEFAULT IMAGE=Imagen defecto'#13+
    'HORIZONTAL SIZE=Tamaño Horiz.'#13+
    'VERTICAL SIZE=Tamaño Vert.'#13+
    'MOVE HORIZ=Mover horiz.'#13+
    'MOVE VERT=Mover vert.'#13+
    'EDIT CONNECTION=Editar Conexión'#13+
    'DELETE CONNECTION=Borrar Conexión'#13+
    'ADD NEW POINT=Añadir Punto'#13+
    'DELETE POINT=Eliminar Punto'#13+
    'FIXED=Fijo'#13+
    'ELECTRIC=Eléctricas';
end;

Procedure TreeSetCatalan;

Procedure SetCatalanConstants;
begin
  TreeMsg_Browse         := '&Obrir Imatge...';
  TreeMsg_Clear          := '&Treure Imatge';

  TeeMsg_TreeCopyright    := '© 1998-2006 per David Berneda';
  TeeMsg_TreePrintPreview := '&Vista Preliminar...';
  TeeMsg_TreeExportChart  := 'E&xportar Tree...';
  TeeMsg_TreeAbout        := '&Referència de TeeTree...';
  TeeMsg_TreeLoad         := '&Obrir TeeTree...';
  TeeMsg_TreeFiles        := 'Arxius TeeTree v'+TeeTree_MajorVersion+' (*.ttr)|*.ttr';
  TeeMsg_TreeEdit         := 'E&ditar Tree...';
  TeeMsg_TreeSureDelete   := '¿Segur que desitjes eliminar els nodes?';
  TreeMsg_Connection      := 'Conexió';
  TreeMsg_CannotSetShape  := 'Utilitza la propietat Tree. La propietat Shapes es de només lectura.';
  TreeMsg_Editing         := 'Editant %s';

  TreeMsg_Child           := 'Fill';
  TreeMsg_Root            := 'Arrel';
  TreeMsg_ExportTree      := 'Exportar Tree';
  TreeMsg_SureToNew       := '¿Segur que desitjes borrar el diagrama? Compte: No es pot desfer el borrat.';
  TreeMsg_SearchNode      := 'Buscar nodes amb...';
  TreeMsg_NodeText        := 'Texte:';
  TreeMsg_ClickTwoShapes  := 'Fes clic a dos nodes per conectar-los. Pulsa ESCAPE per cancelar.';

  TreeMsg_About           := 'Referència de %s...';

  TreeMsg_EditingMode     := 'Editant node: ';

  { DBTree }
  TreeMsg_DBCodeNeeded := 'Els camps Códi, Pare y Texte tenen que ser seleccionats.';
  TreeMsg_DBTextNeeded := 'Els camps Texte tenen que ser seleccionats.';
  TreeMsg_SureToCancel := '¿Segur que desitjes cancelar els canvis?';
  TreeMsg_MasterNeed   := 'Els camps Master tenen que ser seleccionats';
  TreeMsg_DetailNeed   := 'Els camps Detall tenen que ser seleccionats';

  TreeMsg_GroupField   := 'Camp &Grup:';
  TreeMsg_ParentField  := 'Camp &Pare:';
  TreeMsg_MasterFields := 'Camps Master:';
  TreeMsg_TextFields   := 'Camps &Texte:';
  TreeMsg_MasterDataset:= 'TaulaMaster:';
  TreeMsg_DataSet      := '&Taula:';

  TreeMsg_DBFieldNotFound := 'El camp %s no es trova a la taula %s';
  TeeMsg_TreeDBRefresh    := 'Refrescar Taula';
  TeeMsg_TreeDBWizard     := 'Asistent de Base de Dades...';
  TreeMsg_OneTextField    := 'Al menys un camp de Texte té que ser seleccionat.';
  TreeMsg_OneDetailField  := 'Al menys un camp de Detalle té que ser seleccionat.';
  TreeMsg_OneParentField  := 'El camp Pare té que ser seleccionat.';

  TreeMsg_Finish       := '&Finalitzar';
  TreeMsg_Next         := '&Seguent >';

  TreeMsg_TreeEditor     := 'Editor TeeTree';

  { Shape tabs }
  TeeTree_tabFlow        :='Diagrames';
  TeeTree_tabElectric    :='Electriques';
  TeeTree_tabOther       :='Altres';
  TeeTree_tabTransit     :='Trànsit';

  TreeMsg_EditorTips   := 'Ajuda de l''editor TeeTree:'+#13+#13+
   'Fes Clic a un node amb botó DRET per mostrar el menú del node.'+#13+
   'DOBLE clic a un node amb botón ESQUERRA per editar el node.'+#13+#13+
   'Selecció de nodes:'+#13+
   'CLIC a un node per seleccionar-lo.'+#13+
   ' Pulsa la tecla MAJU (shift) i clic a nodes per selecció múltiple.'+#13+
   ' Pulsa la tecla CONTROL (ctrl) i clic a un node per seleccionar també els seus fills.'+#13+#13+
   'Desplaça el ratolí amb botó DRET en el panel per desplaçament.'+#13+
   'Amb botó ESQUERRA dibuixa un rectàngle per seleccionar els nodes que hi ha dins.'+#13+#13+
   'Usa les tecles de fletxes amb CONTROL i MAJU (shift) per moure / redimensionar.'+#13+
   'Pulsa la tecla SUPRIMIR per borrar els nodes seleccionats.'+#13+#13+
   'Clic a una conexió per seleccionar-la.';

  TreeMsg_Caps            :='MAJU';
  TreeMsg_Num             :='NUM';
  TreeMsg_SCR             :='DES';

  TreeMsg_ImportTextFile  :='Importar nodes des d''arxiu de texte';
  TreeMsg_Point:='Punt';
  TreeMsg_TreeNil := 'La propiedat Tree està buida.';
end;

begin
  SetCatalanConstants;

  TeeSetCatalan;

  with TeeCatalanLanguage do
  if IndexOfName('FLOWCHART')=-1 then
    Text:=Text+#13+
    'FLOWCHART=Diagrames'#13+
    'INSERT=Insertar'#13+
    'NODES=Nodes'#13+
    'DESIGN=Diseny'#13+
    'PREVIEW=Navegació'#13+
    'ABOUT TEETREE=Referència de TeeTree'#13+
    'EDITOR TIPS=Ús de l''Editor'#13+
    'TEETREE WEB SITE=Lloc web de TeeTree'#13+
    'LINK NODES=Unir nodes'#13+
    'PRUNE NODES=Desconectar nodes'#13+
    'CLIP TEXT=Ocultar texte'#13+
    'SHADOW COLOR=Color d''Ombra'#13+
    'NEW CHILD=Afegir fill'#13+
    'NEW BROTHER=Afegir germà'#13+
    'NEW ROOT=Afegir node arrel'#13+
    'NEW PARENT=Afegir pare'#13+
    'CONNECTIONS=Conexions'#13+
    'IMAGES=Imàtges'#13+
    'CROSS BOXES=Caixes d''expansió'#13+
    'EDITOR TABS=Pantalles editor'#13+
    'SHAPE TABS=Formes de nodes'#13+
    'RULERS=Guies'#13+
    'TOOLBAR=Barra d''eines'#13+
    'FONT TOOLBAR=Barra font'#13+
    'BORDER TOOLBAR=Barra format'#13+
    'NODE TREE=Àrbre de nodes'#13+
    'CUT=Tallar'#13+
    'PASTE=Enganxar'#13+
    'SEARCH=Buscar nodes'#13+
    'ALIGN TO GRID=Alinear a graella'#13+
    'IMPORT=Importar'#13+
    'NEW TREE=Nou Diagrama'#13+
    'PRINT TREE=Imprimir Diagrama'#13+
    'ZOOM IN=Apropar'#13+
    'ZOOM OUT=Allunyar'#13+
    'CONNECT NODES=Conectar nodes'#13+
    'ADD CHILD=Afegir fill'#13+
    'ADD BROTHER=Afegir germà'#13+
    'PRUNE=Desconectar'#13+
    'BRING TO FRONT=Moure al front'#13+
    'SEND TO BACK=Moure enrera'#13+
    'ADD NEW ROOT=Afegir nou node arrel'#13+
    'SHOW NAMES=Veure Noms'#13+
    'ALIGN TO LEFT=Alinear a l''esquerra'#13+
    'AUTO SCROLL=Desplaç. Automàtic'#13+
    'BORDER STYLE=Estil llàpis'#13+
    'BORDER COLOR=Color llàpis'#13+
    'BORDER WIDTH=Ample llàpis'#13+
    'DESIGN MODE=Modus Diseny'#13+
    'BUFFERED DISPLAY=Sense parpalleixar'#13+
    'PRINT PANEL=Imprimir Panel'#13+
    'ZOOM FROM CENTER=Zoom des d''el centre'#13+
    'CROSS BOX=Caixes'#13+
    'SIGN PEN=Llàpis signe'#13+
    'MODE=Modus'#13+
    'STRETCHED=Ajustat'#13+
    'ALIGN=Alinear'#13+
    'MOUSE=Ratolí'#13+
    'ALLOW ZOOM=Permetre Zoom'#13+
    'HOTTRACK=Seguiment'#13+
    'MOUSE WHEEL=Roda del ratolí'#13+
    'SELECT NODES=Seleccionar nodes'#13+
    'SCROLL VERT.=Desplaç. Vert.'#13+
    'SCROLL HORIZ.=Desplaç. Horiz.'#13+
    'TEXT COLOR=Color Texte'#13+
    'SCROLL TO VIEW=Forçar visible'#13+
    'UNFOCUSED COLOR=Color sense focus'#13+
    'UNFOCUSED BORDER=Canto sense focus'#13+
    'ALLOW DELETE=Permetre borrar'#13+
    'SINGLE SELECTION=Selecció única'#13+
    'SCROLL BARS=Barras Desplaç.'#13+
    'GRID VISIBLE=Veure graella'#13+
    'SNAP TO GRID=Ajust a graella'#13+
    'SHOW RULERS=Veure guies'#13+
    'INTERCHAR SPACING=Espaciat'#13+
    'VERT. ALIGN=Alinear Vert.'#13+
    'ARROW FROM=Fletxa desde'#13+
    'ARROW TO=Fletxa fins'#13+
    'SIDES=Costats'#13+
    'CURVE=Curva'#13+
    'CHILDREN CONNECTIONS=Conexions'#13+
    'CROSS-BOX=Caixa'#13+
    'HORIZONTAL ALIGNMENT=Alinear Horiz.'#13+
    'DEFAULT IMAGE=Imatge defecte'#13+
    'HORIZONTAL SIZE=Tamany Horiz.'#13+
    'VERTICAL SIZE=Tamany Vert.'#13+
    'MOVE HORIZ=Moure horiz.'#13+
    'MOVE VERT=Moure vert.'#13+
    'EDIT CONNECTION=Editar Conexió'#13+
    'DELETE CONNECTION=Borrar Conexió'#13+
    'ADD NEW POINT=Afegir Punt'#13+
    'DELETE POINT=Eliminar Punt'#13+
    'FIXED=Fixe'
    ;

  TeeSetCatalan;
end;

Procedure TreeSetGerman;

Procedure SetGermanConstants;
begin
end;

begin
  SetGermanConstants;

  TeeSetGerman;

  with TeeGermanLanguage do
  if IndexOfName('FLOWCHART')=-1 then
    Text:=Text+#13
    ;

  TeeSetGerman;
end;

Procedure TreeSetFrench;

Procedure SetFrenchConstants;
begin
end;

begin
  SetFrenchConstants;

  TeeSetFrench;

  with TeeFrenchLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetFrench;
end;

Procedure TreeSetBrazil;

Procedure SetBrazilConstants;
begin
end;

begin
  SetBrazilConstants;

  TeeSetBrazil;

  with TeeBrazilLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetBrazil;
end;

Procedure TreeSetDanish;

Procedure SetDanishConstants;
begin
end;

begin
  SetDanishConstants;

  TeeSetDanish;

  with TeeDanishLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetDanish;
end;

Procedure TreeSetDutch;

Procedure SetDutchConstants;
begin
end;

begin
  SetDutchConstants;

  TeeSetDutch;

  with TeeDutchLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetDutch;
end;

Procedure TreeSetSwedish;

Procedure SetSwedishConstants;
begin
  TreeMsg_Browse         := '&Bläddra tillbaka bild...';
  TreeMsg_Clear          := 'Töm bakgrundsbild';

  TeeMsg_TreeCopyright    := '(c) 1998-2006 av David Berneda';
  TeeMsg_TreePrintPreview := 'Förhandsgranska...';
  TeeMsg_TreeExportChart  := 'Exportera träd...';
  TeeMsg_TreeAbout        := 'Om TeeTree...';
  TeeMsg_TreeLoad         := 'Ladda träd...';
  TeeMsg_TreeFiles        := 'TeeTree v'+TeeTree_MajorVersion+' filer (*.ttr)|*.ttr';
  TeeMsg_TreeEdit         := 'Editera Träd...';
  TeeMsg_TreeSureDelete   := 'Säkert att du vill du radera Noder?';
  TreeMsg_Connection      := 'Koppling';
  TreeMsg_CannotSetShape  := 'Använd träd egenskap. Form egenskap är endast läsbar';
  TreeMsg_Editing         := 'Redigerar %s';

  TreeMsg_Child           := 'Barn';
  TreeMsg_Root            := 'Rot';
  TreeMsg_ExportTree      := 'Exportera Träd';
  TreeMsg_SureToNew       := 'Säker på att du vill radera aktuellt träd? Varning: Handling kan inte ångras';
  TreeMsg_SearchNode      := 'Sök noder med...';
  TreeMsg_NodeText        := 'Text:';
  TreeMsg_ClickTwoShapes  := 'Klicka på två noder för att koppla ihop dem. Tryck ESC för att upphäva.';

  TreeMsg_About           := 'Om %s...';

  TreeMsg_EditingMode     := 'Redigerar Mode: ';

  { DBTree }
  TreeMsg_DBCodeNeeded := 'Kod, Förälder och Text fält ska vara valda';
  TreeMsg_DBTextNeeded := 'Text fält ska vara valt';
  TreeMsg_SureToCancel := 'Säker på att upphäva ändringar?';
  TreeMsg_MasterNeed   := 'Huvudfält ska vara valt';
  TreeMsg_DetailNeed   := 'Detalj fält ska vara valt';

  TreeMsg_GroupField   := 'Grupp fält:';
  TreeMsg_ParentField  := '&Förälder fält:';
  TreeMsg_MasterFields := 'Huvud fält:';
  TreeMsg_TextFields   := 'Text fält:';
  TreeMsg_MasterDataset:= 'Huvud Dataset:';
  TreeMsg_DataSet      := 'Dataset:';

  TreeMsg_DBFieldNotFound := 'Fält %s kunde inte hittas i tabell %s';
  TeeMsg_TreeDBRefresh    := 'Uppdatera DataSet';
  TeeMsg_TreeDBWizard     := 'Databas Rådgivare...';
  TreeMsg_OneTextField    := 'Minst ett text fält ska vara valt.';
  TreeMsg_OneDetailField  := 'Minst ett detaljfält ska vara valt.';
  TreeMsg_OneParentField  := 'Föräldra fält ska vara valt.';

  TreeMsg_Finish       := '&Avsluta';
  TreeMsg_Next         := '&Nästa >';

  TreeMsg_TreeEditor     := 'Träd Editor';

  { Shape tabs }
  TeeTree_tabFlow        :='Flödesschema';
  TeeTree_tabElectric    :='Elektrisk';
  TeeTree_tabOther       :='Annan';
  TeeTree_tabUML         :='UML';

  TreeMsg_EditorTips   := 'TeeTree Redigerings Tips:'+#13+#13+
   'HÖGER klicka en form eller koppling för att visa POPUP MENY'+#13+
   'DUBBEL klicka en form med VÄNSTER mus knapp för att REDIGERA den'+#13+#13+
   'Form val:'+#13+
   'VÄLJ en form genom att KLICKA på den'+#13+
   'Tryck SHIFT och klicka på en form för att VÄLJA FLERA än en'+#13+
   'Tryck CTRL och klicka en form för att välja BARN också'+#13+#13+
   'HÖGER klicka på panelen och DRAG musen för att skrolla'+#13+
   'Med VÄNSTER musknapp, välj en rektangel för att välja'+#13+#13+
   'Använd piltangenter och CTRL och SHIFT för att flytta/ändra storlek på form'+#13+
   'Tryck DELETE för att RADERA valda former'+#13+#13+
   'Klicka på en Koppling för att VÄLJA den ';

  TreeMsg_Caps :='CAPS';
  TreeMsg_Num  :='NUM';
  TreeMsg_SCR  :='SCR';
  TreeMsg_ImportTextFile:='Importera Träd noder fråm en textfil';
  TreeMsg_Point:='Punkt';

  TreeMsg_TreeNil := 'Tree property should be assigned.';
end;

begin
  SetSwedishConstants;

  TeeSetSwedish;

  with TeeSwedishLanguage do
  if IndexOfName('FLOWCHART')=-1 then
    Text:=Text+#13+
    'FLOWCHART=FlödesSchema'#13+
    'INSERT=Infoga'#13+
    'NODES=Noder'#13+
    'DESIGN=Design'#13+
    'PREVIEW=Förhandsgranska'#13+
    'ABOUT TEETREE=Om TeeTree'#13+
    'EDITOR TIPS=Editor tips'#13+
    'TEETREE WEB SITE=TeeTree Web plats'#13+
    'LINK NODES=Linka noder'#13+
    'PRUNE NODES=Avlägsna noder'#13+
    'CLIP TEXT=Klipp text'#13+
    'SHADOW COLOR=Skuggfärg'#13+
    'NEW CHILD=Nytt barn'#13+
    'NEW BROTHER=Ny broder'#13+
    'NEW ROOT=Ny Rot'#13+
    'NEW PARENT=Ny förälder'#13+
    'CONNECTIONS=Kopplingar'#13+
    'IMAGES=Bilder'#13+
    'CROSS BOXES=Kryss boxar'#13+
    'EDITOR TABS=Editor tabbar'#13+
    'SHAPE TABS=Form tabbar'#13+
    'RULERS=Linjaler'#13+
    'TOOLBAR=Verktygs list'#13+
    'FONT TOOLBAR=Font list'#13+
    'BORDER TOOLBAR=Kant list'#13+
    'NODE TREE=Nodträd'#13+
    'CUT=Klipp ut'#13+
    'PASTE=Klistra in'#13+
    'SEARCH=Sök'#13+
    'ALIGN TO GRID=Anpassa till grid'#13+
    'IMPORT=Importera'#13+
    'NEW TREE=Nytt träd'#13+
    'PRINT TREE=Skriv ut träd'#13+
    'ZOOM IN=Zomma in'#13+
    'ZOOM OUT=Zomma ut'#13+
    'CONNECT NODES=Koppla ihop noder'#13+
    'ADD CHILD=Addera barn'#13+
    'ADD BROTHER=Addera broder'#13+
    'PRUNE=Beskär'#13+
    'BRING TO FRONT=Flytta längst fram'#13+
    'SEND TO BACK=Skicka till bakom'#13+
    'ADD NEW ROOT=Addera ny rot'#13+
    'SHOW NAMES=Visa namn'#13+
    'ALIGN TO LEFT=Anpassa till vänster'#13+
    'AUTO SCROLL=Automatisk skroll'#13+
    'BORDER STYLE=Kant stil'#13+
    'BORDER COLOR=Kant färg'#13+
    'BORDER WIDTH=Kant bredd'#13+
    'DESIGN MODE=Design läge'#13+
    'BUFFERED DISPLAY=Buffrad skärm'#13+
    'PRINT PANEL=Skrivare panel'#13+
    'ZOOM FROM CENTER=Zooma från centrum'#13+
    'CROSS BOX=Kryss box'#13+
    'SIGN PEN=Signerings penna'#13+
    'MODE=Läge'#13+
    'STRETCHED=Utsträckt'#13+
    'ALIGN=Passa'#13+
    'MOUSE=Mus'#13+
    'ALLOW ZOOM=Tillåt zooom'#13+
    'HOTTRACK=Hett spår'#13+
    'MOUSE WHEEL=Mus hjul'#13+
    'SELECT NODES=Välj noder'#13+
    'SCROLL VERT.=Skrolla Vert.'#13+
    'SCROLL HORIZ.=Skrolla Horiz.'#13+
    'TEXT COLOR=Text färg'#13+
    'SCROLL TO VIEW=Skrolla för att visa'#13+
    'UNFOCUSED COLOR=Ofokuserad färg'#13+
    'UNFOCUSED BORDER=Ofokuserad kant'#13+
    'ALLOW DELETE=Tillåt radera'#13+
    'SINGLE SELECTION=Enkel val'#13+
    'SCROLL BARS=Skroll lister.'#13+
    'GRID VISIBLE=Synligt grid'#13+
    'SNAP TO GRID=Justera till grid'#13+
    'SHOW RULERS=Visa linjaler'#13+
    'INTERCHAR SPACING=Mellanslag steg'#13+
    'VERT. ALIGN= Passa Vert.'#13+
    'ARROW FROM=Pil från'#13+
    'ARROW TO=Pil till'#13+
    'SIDES=Sidor'#13+
    'CURVE=Kurva'#13+
    'CHILDREN CONNECTIONS=Barn kopplingar'#13+
    'CROSS-BOX=Kryss box'#13+
    'HORIZONTAL ALIGNMENT=Passa Horiz.'#13+
    'DEFAULT IMAGE=Förvald bild'#13+
    'HORIZONTAL SIZE=Horizontell storlek.'#13+
    'VERTICAL SIZE=Vertikal storlek.'#13+
    'MOVE HORIZ=Flytta horizontellt.'#13+
    'MOVE VERT=Flytta vertikallt.'#13+
    'EDIT CONNECTION=Redigera koppling'#13+
    'DELETE CONNECTION=Radera koppling'#13+
    'ADD NEW POINT=Addera ny punkt'#13+
    'DELETE POINT=Radera punkt'#13+
    'FIXED=Fixerad';

  TeeSetSwedish;
end;

Procedure TreeSetChinese;

Procedure SetChineseConstants;
begin
end;

begin
  SetChineseConstants;

  TeeSetChinese;

  with TeeChineseLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetChinese;
end;

Procedure TreeSetChineseSimp;

Procedure SetChineseSimpConstants;
begin
end;

begin
  SetChineseSimpConstants;

  TeeSetChineseSimp;

  with TeeChineseSimpLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetChineseSimp;
end;

Procedure TreeSetPortuguese;

Procedure SetPortugueseConstants;
begin
end;

begin
  SetPortugueseConstants;

  TeeSetPortuguese;

  with TeePortugueseLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetPortuguese;
end;

Procedure TreeSetRussian;

Procedure SetRussianConstants;
begin
end;

begin
  SetRussianConstants;

  TeeSetRussian;

  with TeeRussianLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetRussian;
end;

Procedure TreeSetItalian;

Procedure SetItalianConstants;
begin
end;

begin
  SetItalianConstants;

  TeeSetItalian;

  with TeeItalianLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetItalian;
end;

Procedure TreeSetNorwegian;

Procedure SetNorwegianConstants;
begin
end;

begin
  SetNorwegianConstants;

  TeeSetNorwegian;

  with TeeNorwegianLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetNorwegian;
end;

Procedure TreeSetJapanese;

Procedure SetJapaneseConstants;
begin
end;

begin
  SetJapaneseConstants;

  TeeSetJapanese;

  with TeeJapaneseLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetJapanese;
end;

Procedure TreeSetPolish;

Procedure SetPolishConstants;
begin
  TreeMsg_Browse         := '&Przegl¹daj obrazki t³a...';
  TreeMsg_Clear          := '&Usuñ obrazek t³a';

  TeeMsg_TreeCopyright    := '© 1998-2006 by David Berneda';
  TeeMsg_TreePrintPreview := '&Podg³¹d wydruku...';
  TeeMsg_TreeExportChart  := 'Ek&sport drzewka...';
  TeeMsg_TreeAbout        := '&O TeeTree...';
  TeeMsg_TreeLoad         := '&Wczytaj drzewko...';
  TeeMsg_TreeFiles        := 'Pliki TeeTree v'+TeeTree_MajorVersion+' (*.ttr)|*.ttr';
  TeeMsg_TreeEdit         := '&Edycja drzewka...';
  TeeMsg_TreeSureDelete   := 'Na pewno skasowaæ wêz³y?';
  TreeMsg_Connection      := 'Po³¹czenie';
  TreeMsg_CannotSetShape  := 'U¿yj w³aœciwoœci drzewka. W³aœciwoœæ Kszta³t jest tylko do odczytu';
  TreeMsg_Editing         := 'Edycja %s';

  TreeMsg_Child           := 'Potomek';
  TreeMsg_Root            := 'Korzeñ';
  TreeMsg_ExportTree      := 'Eksport drzewka';
  TreeMsg_SureToNew       := 'Na pewno wyczyœciæ drzewko? Uwaga: Operacja jest nieodwracalna';
  TreeMsg_SearchNode      := 'Przeszukuj wêz³y z...';
  TreeMsg_NodeText        := 'Tekst:';
  TreeMsg_ClickTwoShapes  := 'Kliknij dwa wêz³y aby je po³¹czyæ. Wciœnij ESC aby anulowaæ.';

  TreeMsg_About           := 'O %s...';

  TreeMsg_EditingMode     := 'Edytowany wêze³: ';

  { DBTree }
  TreeMsg_DBCodeNeeded := 'Wymagane jest zaznaczenie pól Code, Parent i Text';
  TreeMsg_DBTextNeeded := 'Wymagane jest zaznaczenie pola Text';
  TreeMsg_SureToCancel := 'Na pewno anulowaæ zmiany?';
  TreeMsg_MasterNeed   := 'Wymagane jest zaznaczenie pola Master';
  TreeMsg_DetailNeed   := 'Wymagane jest zaznaczenie pola Detail';

  TreeMsg_GroupField   := 'Pole &grupuj¹ce:';
  TreeMsg_ParentField  := 'Pole &przodka:';
  TreeMsg_MasterFields := 'Pola g³ówne:';
  TreeMsg_TextFields   := 'Pole &tekstowe:';
  TreeMsg_MasterDataset:= 'Dane g³ówne:';
  TreeMsg_DataSet      := '&Dane:';

  TreeMsg_DBFieldNotFound := 'Pola %s nie znaleziono w tablicy %s';
  TeeMsg_TreeDBRefresh    := 'Odœwie¿ dane';
  TeeMsg_TreeDBWizard     := 'Kreator bazy danych...';
  TreeMsg_OneTextField    := 'Powinno byæ zaznaczone przynajmniej jedno pole tekstowe .';
  TreeMsg_OneDetailField  := 'Powinno byæ zaznaczone przynajmniej jedno pole szczegó³ow.';
  TreeMsg_OneParentField  := 'Powinno byæ zaznaczone pole przodka.';

  TreeMsg_Finish       := '&Zakoñcz';
  TreeMsg_Next         := '&Dalej >';

  TreeMsg_TreeEditor     := 'Edytor drzewa';

  { Shape tabs }
  TeeTree_tabFlow        :='Wykres';
  TeeTree_tabElectric    :='Elektryczny';
  TeeTree_tabOther       :='Inny';
  TeeTree_tabUML         :='UML';

  TreeMsg_EditorTips   := 'Porady dla edytora TeeTree:'+#13+#13+
   'Kliknij prawym klawiszem myszy na kszta³cie aby zobaczyæ listê mo¿liwoœci'+#13+
   'Kliknij dwukrotnie na kszta³cie aby przejœæ w tryb edycji'+#13+#13+
   'Wybór kszta³tu:'+#13+
   'Kliknij na kszta³t aby go zaznaczyæ'+#13+
   ' Aby zaznaczyæ kilka kszta³tów kliknij na nie przy wciœniêtym klawiszu SHIFT'+#13+
   ' Aby zaznaczyæ tak¿e potomków kszta³tu klikaj na kszta³ty przy wciœniêtym klawiszu CTRL'+#13+#13+
   'Przesuwanie myszki nad panelem z wciœniêtym prawym klawiszem powoduje przesuwanie widoku'+#13+
   'Aby zaznaczyæ wiele kszta³tów wciœnij lewy klawisz i umiœæ zaznaczane kszta³ty w rysowanym prostok¹cie'+#13+#13+
   'Przy pomocy strza³ek na klawiaturze i klawiszy CTRL i SHIFT mo¿esz przesuwaæ i zmieniaæ rozmiar kszta³tów'+#13+
   'Klawisz DELETE usuwa kszta³ty'+#13+#13+
   'Kliknij po³¹czenie aby je wybraæ';

  TreeMsg_Caps :='CAPS';
  TreeMsg_Num  :='NUM';
  TreeMsg_SCR  :='SCR';
  TreeMsg_ImportTextFile:='Importuj ga³êzie drzewa z pliku tekstowego';
  TreeMsg_Point:='Punkt';
  TreeMsg_TreeNil := 'Tree property should be assigned.';
end;

begin
  SetPolishConstants;

  TeeSetPolish;

  with TeePolishLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetPolish;
end;

Procedure TreeSetSlovene;

Procedure SetSloveneConstants;
begin
end;

begin
  SetSloveneConstants;

  TeeSetSlovene;

  with TeeSloveneLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetSlovene;
end;

Procedure TreeSetTurkish;

Procedure SetTurkishConstants;
begin
end;

begin
  SetTurkishConstants;

  TeeSetTurkish;

  with TeeTurkishLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetTurkish;
end;

Procedure TreeSetHungarian;

Procedure SetHungarianConstants;
begin
end;

begin
  SetHungarianConstants;

  TeeSetHungarian;

  with TeeHungarianLanguage do
  if IndexOfName('FLOWCHART')=-1 then ;

  TeeSetHungarian;
end;

initialization
  TreeSetEnglishConstants;
end.
