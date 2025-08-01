unit WiRL.Wizards;

interface

uses
  System.SysUtils,
  ToolsAPI,
  PlatformAPI,
  WinApi.Windows,
  WiRL.Wizards.Dialogs.ServerProject, WiRL.Wizards.Modules.Classes;

resourcestring
  SName = 'WiRL Server Application Wizard';
  SComment = 'Creates a new WiRL Server Application';
  SAuthor = 'WiRL Development Team';
  SGalleryCategory = 'WiRL Library';
  SIDString = 'WiRL.Wizards';

type
  TWiRLServeProjectWizard = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard, IOTARepositoryWizard60,
    IOTARepositoryWizard80, IOTAProjectWizard, IOTAProjectWizard100)
  public
    constructor Create;

    // IOTAWizard
    procedure Execute;
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;

    // IOTARepositoryWizard
    function GetAuthor: string;
    function GetComment: string;
    function GetGlyph: {$IFDEF WIN32}Cardinal{$ELSE}UInt64{$ENDIF};
    function GetPage: string;

    // IOTARepositoryWizard60
    function GetDesigner: string;

    // IOTARepositoryWizard80
    function GetGalleryCategory: IOTAGalleryCategory;
    function GetPersonality: string;

    // IOTAProjectWizard100
    function IsVisible(Project: IOTAProject): Boolean;
  end;

implementation

uses
  WiRL.Wizards.ProjectCreator;

{ TWiRLServeProjectWizard }

constructor TWiRLServeProjectWizard.Create;
var
  LCategoryServices: IOTAGalleryCategoryManager;
begin
  inherited Create;
  LCategoryServices := BorlandIDEServices as IOTAGalleryCategoryManager;
  LCategoryServices.AddCategory(LCategoryServices.FindCategory(sCategoryRoot), SIDString, SGalleryCategory);
end;

{$REGION 'IOTAWizard'}

procedure TWiRLServeProjectWizard.Execute;
var
  LServerConfig: TServerConfig;
  LModuleServices: IOTAModuleServices;
begin
  if TformServerProjectDialog.FindConfig(LServerConfig) then
  begin
    LModuleServices := BorlandIDEServices as IOTAModuleServices;
    LModuleServices.CreateModule(TWiRLServerProjectCreator.Create(LServerConfig));
//    LModuleServices.CreateModule(TWiRLServerMainFormCreator.Create(LServerConfig));
//    LModuleServices.CreateModule(TWiRLServerResourcesCreator.Create(LServerConfig));
  end;
end;

function TWiRLServeProjectWizard.GetIDString: string;
begin
  Result := SIDString + '.Server';
end;

function TWiRLServeProjectWizard.GetName: string;
begin
  Result := SName;
end;

function TWiRLServeProjectWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TWiRLServeProjectWizard.AfterSave;
begin
end;

procedure TWiRLServeProjectWizard.BeforeSave;
begin
end;

procedure TWiRLServeProjectWizard.Destroyed;
begin
end;

procedure TWiRLServeProjectWizard.Modified;
begin
end;

{$ENDREGION}
{$REGION 'IOTARepositoryWizard'}

function TWiRLServeProjectWizard.GetAuthor: string;
begin
  Result := SAuthor;
end;

function TWiRLServeProjectWizard.GetComment: string;
begin
  Result := SComment;
end;

function TWiRLServeProjectWizard.GetGlyph: {$IFDEF WIN32}Cardinal{$ELSE}UInt64{$ENDIF};
begin
{ TODO : function TWiRLServeProjectWizard.GetGlyph: Cardinal; }
  Result := LoadIcon(HInstance, 'WiRLServerWizardIcon');
end;

function TWiRLServeProjectWizard.GetPage: string;
begin
  Result := SGalleryCategory;
end;

{$ENDREGION}
{$REGION 'IOTARepositoryWizard60'}

function TWiRLServeProjectWizard.GetDesigner: string;
begin
  Result := dAny;
end;

{$ENDREGION}
{$REGION 'IOTARepositoryWizard80'}

function TWiRLServeProjectWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := (BorlandIDEServices as IOTAGalleryCategoryManager).FindCategory(SIDString);
end;

function TWiRLServeProjectWizard.GetPersonality: string;
begin
  Result := sDelphiPersonality;
end;

{$ENDREGION}
{$REGION 'IOTAProjectWizard100'}

function TWiRLServeProjectWizard.IsVisible(Project: IOTAProject): Boolean;
begin
  Result := True;
end;

{$ENDREGION}


end.
