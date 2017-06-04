function UpdateUndoList(New, IS_IT_NEW)

UndoList = evalin('base','UndoList');
UndoListCnt = evalin('base','UndoListCnt');

if IS_IT_NEW == 1
    UndoListCnt = UndoListCnt+1;
    temp = numel(New);
    UndoList(UndoListCnt,1:temp) = New(1,1:temp);
else
    ColumnCnt = numel(UndoList(1,:));
    temp = numel(New);
    UndoList(UndoListCnt,ColumnCnt+1:ColumnCnt+temp) = New(1,1:temp);
end;

assignin('base', 'UndoList', UndoList);
assignin('base', 'UndoListCnt', UndoListCnt);