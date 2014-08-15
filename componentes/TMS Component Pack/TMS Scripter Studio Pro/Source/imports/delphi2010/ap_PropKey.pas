{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_PropKey;

interface

uses
  ActiveX,
  PropKey,
  Variants,
  ap_ActiveX,
  atScript;

{$WARNINGS OFF}

type
  TatPropKeyLibrary = class(TatScripterLibrary)
    procedure __GetPKEY_Audio_ChannelCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_Compression(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_EncodingBitrate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_Format(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_IsVariableBitRate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_PeakValue(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_SampleRate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_SampleSize(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_StreamName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Audio_StreamNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_Duration(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_IsOnline(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_IsRecurring(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_Location(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_OptionalAttendeeAddresses(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_OptionalAttendeeNames(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_OrganizerAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_OrganizerName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_ReminderTime(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_RequiredAttendeeAddresses(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_RequiredAttendeeNames(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_Resources(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_ResponseStatus(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_ShowTimeAs(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Calendar_ShowTimeAsText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_AccountName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_DateItemExpires(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_FollowupIconIndex(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_HeaderItem(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_PolicyTag(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_SecurityFlags(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_Suffix(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_TaskStatus(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Communication_TaskStatusText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Computer_DecoratedFreeSpace(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Anniversary(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_AssistantName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_AssistantTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Birthday(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessAddressCity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessAddressCountry(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessAddressPostalCode(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessAddressPostOfficeBox(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessAddressState(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessAddressStreet(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessFaxNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessHomePage(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_BusinessTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_CallbackTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_CarTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Children(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_CompanyMainTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Department(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_EmailAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_EmailAddress2(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_EmailAddress3(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_EmailAddresses(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_EmailName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_FileAsName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_FirstName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_FullName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Gender(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_GenderValue(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Hobbies(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeAddressCity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeAddressCountry(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeAddressPostalCode(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeAddressPostOfficeBox(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeAddressState(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeAddressStreet(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeFaxNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_HomeTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_IMAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Initials(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_JA_CompanyNamePhonetic(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_JA_FirstNamePhonetic(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_JA_LastNamePhonetic(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_JobTitle(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Label(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_LastName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_MailingAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_MiddleName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_MobileTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_NickName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_OfficeLocation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_OtherAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_OtherAddressCity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_OtherAddressCountry(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_OtherAddressPostalCode(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_OtherAddressPostOfficeBox(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_OtherAddressState(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_OtherAddressStreet(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PagerTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PersonalTitle(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PrimaryAddressCity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PrimaryAddressCountry(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PrimaryAddressPostalCode(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PrimaryAddressPostOfficeBox(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PrimaryAddressState(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PrimaryAddressStreet(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PrimaryEmailAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_PrimaryTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Profession(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_SpouseName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_Suffix(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_TelexNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_TTYTDDTelephone(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Contact_WebPage(AMachine: TatVirtualMachine);
    procedure __GetPKEY_AcquisitionID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ApplicationName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Author(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Capacity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Category(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Comment(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Company(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ComputerName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ContainedItems(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ContentStatus(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ContentType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Copyright(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DateAccessed(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DateAcquired(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DateArchived(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DateCompleted(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DateCreated(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DateImported(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DateModified(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DueDate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_EndDate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileAllocationSize(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileAttributes(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileDescription(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileExtension(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileFRN(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileOwner(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FileVersion(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FindData(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FlagColor(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FlagColorText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FlagStatus(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FlagStatusText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FreeSpace(AMachine: TatVirtualMachine);
    procedure __GetPKEY_FullText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Identity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Identity_Blob(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Identity_DisplayName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Identity_IsMeIdentity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Identity_PrimaryEmailAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Identity_ProviderID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Identity_UniqueID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Identity_UserName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IdentityProvider_Name(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IdentityProvider_Picture(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ImageParsingName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Importance(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ImportanceText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsAttachment(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsDefaultNonOwnerSaveLocation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsDefaultSaveLocation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsDeleted(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsEncrypted(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsFlagged(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsFlaggedComplete(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsIncomplete(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsPinnedToNameSpaceTree(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsRead(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsSearchOnlyItem(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsSendToTarget(AMachine: TatVirtualMachine);
    procedure __GetPKEY_IsShared(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemAuthors(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemClassType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemDate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemFolderNameDisplay(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemFolderPathDisplay(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemFolderPathDisplayNarrow(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemNameDisplay(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemNamePrefix(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemParticipants(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemPathDisplay(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemPathDisplayNarrow(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemTypeText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ItemUrl(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Keywords(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Kind(AMachine: TatVirtualMachine);
    procedure __GetPKEY_KindText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Language(AMachine: TatVirtualMachine);
    procedure __GetPKEY_MileageInformation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_MIMEType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Null(AMachine: TatVirtualMachine);
    procedure __GetPKEY_OfflineAvailability(AMachine: TatVirtualMachine);
    procedure __GetPKEY_OfflineStatus(AMachine: TatVirtualMachine);
    procedure __GetPKEY_OriginalFileName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_OwnerSID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ParentalRating(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ParentalRatingReason(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ParentalRatingsOrganization(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ParsingBindContext(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ParsingName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ParsingPath(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PerceivedType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PercentFull(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Priority(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PriorityText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Project(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ProviderItemID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Rating(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RatingText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sensitivity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_SensitivityText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_SFGAOFlags(AMachine: TatVirtualMachine);
    procedure __GetPKEY_SharedWith(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ShareUserRating(AMachine: TatVirtualMachine);
    procedure __GetPKEY_SharingStatus(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Shell_OmitFromView(AMachine: TatVirtualMachine);
    procedure __GetPKEY_SimpleRating(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Size(AMachine: TatVirtualMachine);
    procedure __GetPKEY_SoftwareUsed(AMachine: TatVirtualMachine);
    procedure __GetPKEY_SourceItem(AMachine: TatVirtualMachine);
    procedure __GetPKEY_StartDate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Status(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Subject(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Thumbnail(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ThumbnailCacheId(AMachine: TatVirtualMachine);
    procedure __GetPKEY_ThumbnailStream(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Title(AMachine: TatVirtualMachine);
    procedure __GetPKEY_TotalFileSize(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Trademarks(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DeviceInterface_PrinterDriverName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DeviceInterface_PrinterName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DeviceInterface_PrinterPortName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Address(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsAuthenticated(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_BatteryLife(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_BatteryPlusCharging(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_BatteryPlusChargingText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Category_Desc_Singular(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_CategoryGroup_Desc(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Category_Desc_Plural(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_ChargingState(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsConnected(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_ContainerId(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DeviceConnected(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DeviceDescription1(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DeviceDescription2(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DeviceNetworkBytesReceived(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DeviceNetworkBytesSent(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DeviceNetworkConnection(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DeviceNetworkConnectionName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DeviceNetworkUptime(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_DiscoveryMethod(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsEncrypted(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_FriendlyName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_FunctionPaths(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_InterfacePaths(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_InternetConnected(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsDefaultDevice(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsNetworkDevice(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsSharedDevice(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Last_Connected(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Last_Seen(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_LaunchDXPFromExplorer(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsLocalMachine(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Manufacturer(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_MissedCalls(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_ModelName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_NetworkName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_NetworkType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_NewPictures(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Notification(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Notification_LowBattery(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Notification_MissedCall(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Notification_NewMessage(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Notification_NewVoicemail(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Notification_StorageFull(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Notification_StorageFullLinkText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_NotificationStore(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsNotWorkingProperly(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_IsPaired(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_PrimaryCategory(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Roaming(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_SafeRemovalRequired(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_SignalStrength(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Status1(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Status2(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_StorageCapacity(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_StorageFreeSpace(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_StorageFreeSpacePercent(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_TextMessages(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Version(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Devices_Voicemail(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_ByteCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_CharacterCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_ClientID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_Contributor(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_DateCreated(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_DatePrinted(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_DateSaved(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_Division(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_DocumentID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_HiddenSlideCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_LastAuthor(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_LineCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_Manager(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_MultimediaClipCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_NoteCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_PageCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_ParagraphCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_PresentationFormat(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_RevisionNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_Security(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_SlideCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_Template(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_TotalEditingTime(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_Version(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Document_WordCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DRM_DatePlayExpires(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DRM_DatePlayStarts(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DRM_Description(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DRM_IsProtected(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DRM_PlayCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Altitude(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_AltitudeDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_AltitudeNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_AltitudeRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_AreaInformation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Date(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestBearing(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestBearingDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestBearingNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestBearingRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestDistance(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestDistanceDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestDistanceNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestDistanceRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestLatitude(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestLatitudeDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestLatitudeNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestLatitudeRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestLongitude(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestLongitudeDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestLongitudeNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DestLongitudeRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Differential(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DOP(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DOPDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_DOPNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_ImgDirection(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_ImgDirectionDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_ImgDirectionNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_ImgDirectionRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Latitude(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_LatitudeDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_LatitudeNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_LatitudeRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Longitude(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_LongitudeDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_LongitudeNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_LongitudeRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_MapDatum(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_MeasureMode(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_ProcessingMethod(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Satellites(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Speed(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_SpeedDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_SpeedNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_SpeedRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Status(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_Track(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_TrackDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_TrackNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_TrackRef(AMachine: TatVirtualMachine);
    procedure __GetPKEY_GPS_VersionID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_BitDepth(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_ColorSpace(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_CompressedBitsPerPixel(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_CompressedBitsPerPixelDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_CompressedBitsPerPixelNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_Compression(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_CompressionText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_Dimensions(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_HorizontalResolution(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_HorizontalSize(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_ImageID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_ResolutionUnit(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_VerticalResolution(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Image_VerticalSize(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Journal_Contacts(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Journal_EntryType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_LayoutPattern_ContentViewModeForBrowse(AMachine: TatVirtualMachine);
    procedure __GetPKEY_LayoutPattern_ContentViewModeForSearch(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_Arguments(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_Comment(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_DateVisited(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_Description(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_Status(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_TargetExtension(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_TargetParsingPath(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_TargetSFGAOFlags(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_AuthorUrl(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_AverageLevel(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_ClassPrimaryID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_ClassSecondaryID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_CollectionGroupID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_CollectionID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_ContentDistributor(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_ContentID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_CreatorApplication(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_CreatorApplicationVersion(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_DateEncoded(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_DateReleased(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_Duration(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_DVDID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_EncodedBy(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_EncodingSettings(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_FrameCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_MCDI(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_MetadataContentProvider(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_Producer(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_PromotionUrl(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_ProtectionType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_ProviderRating(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_ProviderStyle(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_Publisher(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_SubscriptionContentId(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_SubTitle(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_UniqueFileIdentifier(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_UserNoAutoInfo(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_UserWebUrl(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_Writer(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Media_Year(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_AttachmentContents(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_AttachmentNames(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_BccAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_BccName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_CcAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_CcName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_ConversationID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_ConversationIndex(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_DateReceived(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_DateSent(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_Flags(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_FromAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_FromName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_HasAttachments(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_IsFwdOrReply(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_MessageClass(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_ProofInProgress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_SenderAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_SenderName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_Store(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_ToAddress(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_ToDoFlags(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_ToDoTitle(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Message_ToName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_AlbumArtist(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_AlbumID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_AlbumTitle(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_Artist(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_BeatsPerMinute(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_Composer(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_Conductor(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_ContentGroupDescription(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_Genre(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_InitialKey(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_Lyrics(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_Mood(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_PartOfSet(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_Period(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_SynchronizedLyrics(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Music_TrackNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Note_Color(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Note_ColorText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_Aperture(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ApertureDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ApertureNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_Brightness(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_BrightnessDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_BrightnessNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_CameraManufacturer(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_CameraModel(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_CameraSerialNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_Contrast(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ContrastText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_DateTaken(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_DigitalZoom(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_DigitalZoomDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_DigitalZoomNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_Event(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_EXIFVersion(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureBias(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureBiasDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureBiasNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureIndex(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureIndexDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureIndexNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureProgram(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureProgramText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureTime(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureTimeDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ExposureTimeNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_Flash(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FlashEnergy(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FlashEnergyDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FlashEnergyNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FlashManufacturer(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FlashModel(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FlashText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FNumberDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FNumberNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalLength(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalLengthDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalLengthInFilm(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalLengthNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalPlaneXResolution(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalPlaneXResolutionDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalPlaneXResolutionNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalPlaneYResolution(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalPlaneYResolutionDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_FocalPlaneYResolutionNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_GainControl(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_GainControlDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_GainControlNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_GainControlText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ISOSpeed(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_LensManufacturer(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_LensModel(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_LightSource(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_MakerNote(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_MakerNoteOffset(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_MaxAperture(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_MaxApertureDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_MaxApertureNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_MeteringMode(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_MeteringModeText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_Orientation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_OrientationText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_PeopleNames(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_PhotometricInterpretation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_PhotometricInterpretationText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ProgramMode(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ProgramModeText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_RelatedSoundFile(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_Saturation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_SaturationText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_Sharpness(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_SharpnessText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ShutterSpeed(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ShutterSpeedDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_ShutterSpeedNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_SubjectDistance(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_SubjectDistanceDenominator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_SubjectDistanceNumerator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_TagViewAggregate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_TranscodedForSync(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_WhiteBalance(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Photo_WhiteBalanceText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Advanced(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Audio(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Calendar(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Camera(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Contact(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Content(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Description(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_FileSystem(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_General(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_GPS(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Image(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Media(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_MediaAdvanced(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Message(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Music(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Origin(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_PhotoAdvanced(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_RecordedTV(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropGroup_Video(AMachine: TatVirtualMachine);
    procedure __GetPKEY_InfoTipText(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_ConflictPrompt(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_ContentViewModeForBrowse(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_ContentViewModeForSearch(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_ExtendedTileInfo(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_FileOperationPrompt(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_FullDetails(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_InfoTip(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_NonPersonal(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_PreviewDetails(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_PreviewTitle(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_QuickTip(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_TileInfo(AMachine: TatVirtualMachine);
    procedure __GetPKEY_PropList_XPDetailsPanel(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_ChannelNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_Credits(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_DateContentExpires(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_EpisodeName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_IsATSCContent(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_IsClosedCaptioningAvailable(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_IsDTVContent(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_IsHDContent(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_IsRepeatBroadcast(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_IsSAP(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_NetworkAffiliation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_OriginalBroadcastDate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_ProgramDescription(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_RecordingTime(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_StationCallSign(AMachine: TatVirtualMachine);
    procedure __GetPKEY_RecordedTV_StationName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_AutoSummary(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_ContainerHash(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_Contents(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_EntryID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_ExtendedProperties(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_GatherTime(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_HitCount(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_IsClosedDirectory(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_IsFullyContained(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_QueryFocusedSummary(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_QueryFocusedSummaryWithFallback(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_Rank(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_Store(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_UrlToIndex(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Search_UrlToIndexWithModificationTime(AMachine: TatVirtualMachine);
    procedure __GetPKEY_DescriptionID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_InternalName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_TargetSFGAOFlagsStrings(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Link_TargetUrl(AMachine: TatVirtualMachine);
    procedure __GetPKEY_NamespaceCLSID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Shell_SFGAOFlagsStrings(AMachine: TatVirtualMachine);
    procedure __GetPKEY_AppUserModel_ExcludeFromShowInNewInstall(AMachine: TatVirtualMachine);
    procedure __GetPKEY_AppUserModel_ID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_AppUserModel_IsDestListSeparator(AMachine: TatVirtualMachine);
    procedure __GetPKEY_AppUserModel_RelaunchCommand(AMachine: TatVirtualMachine);
    procedure __GetPKEY_AppUserModel_RelaunchDisplayNameResource(AMachine: TatVirtualMachine);
    procedure __GetPKEY_AppUserModel_RelaunchIconResource(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Software_DateLastUsed(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Software_ProductName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_Comments(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_ConflictDescription(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_ConflictFirstLocation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_ConflictSecondLocation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_HandlerCollectionID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_HandlerID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_HandlerName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_HandlerType(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_HandlerTypeLabel(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_ItemID(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_ItemName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_ProgressPercentage(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_State(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Sync_Status(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Task_BillingInformation(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Task_CompletionStatus(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Task_Owner(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_Compression(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_Director(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_EncodingBitrate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_FourCC(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_FrameHeight(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_FrameRate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_FrameWidth(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_HorizontalAspectRatio(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_SampleSize(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_StreamName(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_StreamNumber(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_TotalBitrate(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Video_VerticalAspectRatio(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Volume_FileSystem(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Volume_IsMappedDrive(AMachine: TatVirtualMachine);
    procedure __GetPKEY_Volume_IsRoot(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatPropKeyLibrary.__GetPKEY_Audio_ChannelCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_ChannelCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_Compression(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_Compression)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_EncodingBitrate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_EncodingBitrate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_Format(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_Format)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_IsVariableBitRate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_IsVariableBitRate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_PeakValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_PeakValue)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_SampleRate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_SampleRate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_SampleSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_SampleSize)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_StreamName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_StreamName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Audio_StreamNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Audio_StreamNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_Duration(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_Duration)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_IsOnline(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_IsOnline)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_IsRecurring(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_IsRecurring)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_Location(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_Location)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_OptionalAttendeeAddresses(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_OptionalAttendeeAddresses)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_OptionalAttendeeNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_OptionalAttendeeNames)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_OrganizerAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_OrganizerAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_OrganizerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_OrganizerName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_ReminderTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_ReminderTime)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_RequiredAttendeeAddresses(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_RequiredAttendeeAddresses)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_RequiredAttendeeNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_RequiredAttendeeNames)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_Resources(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_Resources)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_ResponseStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_ResponseStatus)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_ShowTimeAs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_ShowTimeAs)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Calendar_ShowTimeAsText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Calendar_ShowTimeAsText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_AccountName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_AccountName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_DateItemExpires(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_DateItemExpires)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_FollowupIconIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_FollowupIconIndex)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_HeaderItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_HeaderItem)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_PolicyTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_PolicyTag)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_SecurityFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_SecurityFlags)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_Suffix(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_Suffix)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_TaskStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_TaskStatus)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Communication_TaskStatusText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Communication_TaskStatusText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Computer_DecoratedFreeSpace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Computer_DecoratedFreeSpace)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Anniversary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Anniversary)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_AssistantName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_AssistantName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_AssistantTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_AssistantTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Birthday(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Birthday)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessAddressCity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessAddressCity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessAddressCountry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessAddressCountry)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessAddressPostalCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessAddressPostalCode)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessAddressPostOfficeBox(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessAddressPostOfficeBox)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessAddressState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessAddressState)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessAddressStreet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessAddressStreet)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessFaxNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessFaxNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessHomePage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessHomePage)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_BusinessTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_BusinessTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_CallbackTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_CallbackTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_CarTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_CarTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Children(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Children)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_CompanyMainTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_CompanyMainTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Department(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Department)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_EmailAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_EmailAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_EmailAddress2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_EmailAddress2)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_EmailAddress3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_EmailAddress3)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_EmailAddresses(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_EmailAddresses)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_EmailName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_EmailName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_FileAsName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_FileAsName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_FirstName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_FirstName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_FullName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_FullName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Gender(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Gender)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_GenderValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_GenderValue)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Hobbies(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Hobbies)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeAddressCity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeAddressCity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeAddressCountry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeAddressCountry)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeAddressPostalCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeAddressPostalCode)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeAddressPostOfficeBox(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeAddressPostOfficeBox)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeAddressState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeAddressState)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeAddressStreet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeAddressStreet)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeFaxNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeFaxNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_HomeTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_HomeTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_IMAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_IMAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Initials(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Initials)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_JA_CompanyNamePhonetic(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_JA_CompanyNamePhonetic)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_JA_FirstNamePhonetic(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_JA_FirstNamePhonetic)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_JA_LastNamePhonetic(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_JA_LastNamePhonetic)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_JobTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_JobTitle)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Label(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Label)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_LastName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_LastName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_MailingAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_MailingAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_MiddleName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_MiddleName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_MobileTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_MobileTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_NickName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_NickName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_OfficeLocation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_OfficeLocation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_OtherAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_OtherAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_OtherAddressCity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_OtherAddressCity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_OtherAddressCountry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_OtherAddressCountry)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_OtherAddressPostalCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_OtherAddressPostalCode)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_OtherAddressPostOfficeBox(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_OtherAddressPostOfficeBox)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_OtherAddressState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_OtherAddressState)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_OtherAddressStreet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_OtherAddressStreet)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PagerTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PagerTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PersonalTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PersonalTitle)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PrimaryAddressCity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PrimaryAddressCity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PrimaryAddressCountry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PrimaryAddressCountry)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PrimaryAddressPostalCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PrimaryAddressPostalCode)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PrimaryAddressPostOfficeBox(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PrimaryAddressPostOfficeBox)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PrimaryAddressState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PrimaryAddressState)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PrimaryAddressStreet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PrimaryAddressStreet)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PrimaryEmailAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PrimaryEmailAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_PrimaryTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_PrimaryTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Profession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Profession)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_SpouseName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_SpouseName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_Suffix(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_Suffix)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_TelexNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_TelexNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_TTYTDDTelephone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_TTYTDDTelephone)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Contact_WebPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Contact_WebPage)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_AcquisitionID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_AcquisitionID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ApplicationName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ApplicationName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Author(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Author)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Capacity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Capacity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Category(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Category)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Comment(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Comment)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Company(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Company)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ComputerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ComputerName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ContainedItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ContainedItems)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ContentStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ContentStatus)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ContentType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ContentType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Copyright(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Copyright)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DateAccessed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DateAccessed)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DateAcquired(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DateAcquired)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DateArchived(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DateArchived)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DateCompleted(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DateCompleted)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DateCreated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DateCreated)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DateImported(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DateImported)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DateModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DateModified)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DueDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DueDate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_EndDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_EndDate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileAllocationSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileAllocationSize)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileAttributes)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileDescription(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileDescription)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileExtension(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileExtension)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileFRN(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileFRN)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileOwner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileOwner)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FileVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FileVersion)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FindData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FindData)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FlagColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FlagColor)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FlagColorText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FlagColorText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FlagStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FlagStatus)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FlagStatusText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FlagStatusText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FreeSpace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FreeSpace)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_FullText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_FullText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Identity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Identity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Identity_Blob(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Identity_Blob)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Identity_DisplayName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Identity_DisplayName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Identity_IsMeIdentity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Identity_IsMeIdentity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Identity_PrimaryEmailAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Identity_PrimaryEmailAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Identity_ProviderID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Identity_ProviderID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Identity_UniqueID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Identity_UniqueID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Identity_UserName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Identity_UserName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IdentityProvider_Name(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IdentityProvider_Name)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IdentityProvider_Picture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IdentityProvider_Picture)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ImageParsingName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ImageParsingName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Importance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Importance)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ImportanceText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ImportanceText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsAttachment(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsAttachment)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsDefaultNonOwnerSaveLocation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsDefaultNonOwnerSaveLocation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsDefaultSaveLocation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsDefaultSaveLocation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsDeleted(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsDeleted)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsEncrypted(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsEncrypted)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsFlagged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsFlagged)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsFlaggedComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsFlaggedComplete)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsIncomplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsIncomplete)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsPinnedToNameSpaceTree(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsPinnedToNameSpaceTree)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsRead(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsRead)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsSearchOnlyItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsSearchOnlyItem)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsSendToTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsSendToTarget)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_IsShared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_IsShared)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemAuthors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemAuthors)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemClassType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemClassType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemDate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemFolderNameDisplay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemFolderNameDisplay)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemFolderPathDisplay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemFolderPathDisplay)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemFolderPathDisplayNarrow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemFolderPathDisplayNarrow)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemNameDisplay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemNameDisplay)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemNamePrefix(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemNamePrefix)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemParticipants(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemParticipants)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemPathDisplay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemPathDisplay)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemPathDisplayNarrow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemPathDisplayNarrow)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemTypeText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemTypeText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ItemUrl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ItemUrl)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Keywords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Keywords)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Kind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Kind)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_KindText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_KindText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Language(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Language)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_MileageInformation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_MileageInformation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_MIMEType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_MIMEType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Null(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Null)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_OfflineAvailability(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_OfflineAvailability)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_OfflineStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_OfflineStatus)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_OriginalFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_OriginalFileName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_OwnerSID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_OwnerSID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ParentalRating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ParentalRating)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ParentalRatingReason(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ParentalRatingReason)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ParentalRatingsOrganization(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ParentalRatingsOrganization)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ParsingBindContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ParsingBindContext)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ParsingName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ParsingName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ParsingPath(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ParsingPath)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PerceivedType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PerceivedType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PercentFull(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PercentFull)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Priority(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Priority)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PriorityText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PriorityText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Project(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Project)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ProviderItemID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ProviderItemID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Rating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Rating)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RatingText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RatingText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sensitivity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sensitivity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_SensitivityText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_SensitivityText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_SFGAOFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_SFGAOFlags)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_SharedWith(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_SharedWith)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ShareUserRating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ShareUserRating)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_SharingStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_SharingStatus)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Shell_OmitFromView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Shell_OmitFromView)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_SimpleRating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_SimpleRating)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Size(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Size)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_SoftwareUsed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_SoftwareUsed)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_SourceItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_SourceItem)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_StartDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_StartDate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Status(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Status)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Subject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Subject)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Thumbnail(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Thumbnail)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ThumbnailCacheId(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ThumbnailCacheId)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_ThumbnailStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_ThumbnailStream)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Title(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Title)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_TotalFileSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_TotalFileSize)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Trademarks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Trademarks)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DeviceInterface_PrinterDriverName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DeviceInterface_PrinterDriverName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DeviceInterface_PrinterName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DeviceInterface_PrinterName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DeviceInterface_PrinterPortName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DeviceInterface_PrinterPortName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Address(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Address)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsAuthenticated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsAuthenticated)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_BatteryLife(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_BatteryLife)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_BatteryPlusCharging(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_BatteryPlusCharging)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_BatteryPlusChargingText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_BatteryPlusChargingText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Category_Desc_Singular(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Category_Desc_Singular)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_CategoryGroup_Desc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_CategoryGroup_Desc)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Category_Desc_Plural(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Category_Desc_Plural)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_ChargingState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_ChargingState)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsConnected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsConnected)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_ContainerId(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_ContainerId)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DeviceConnected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DeviceConnected)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DeviceDescription1(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DeviceDescription1)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DeviceDescription2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DeviceDescription2)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DeviceNetworkBytesReceived(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DeviceNetworkBytesReceived)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DeviceNetworkBytesSent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DeviceNetworkBytesSent)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DeviceNetworkConnection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DeviceNetworkConnection)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DeviceNetworkConnectionName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DeviceNetworkConnectionName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DeviceNetworkUptime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DeviceNetworkUptime)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_DiscoveryMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_DiscoveryMethod)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsEncrypted(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsEncrypted)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_FriendlyName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_FriendlyName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_FunctionPaths(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_FunctionPaths)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_InterfacePaths(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_InterfacePaths)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_InternetConnected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_InternetConnected)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsDefaultDevice(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsDefaultDevice)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsNetworkDevice(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsNetworkDevice)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsSharedDevice(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsSharedDevice)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Last_Connected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Last_Connected)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Last_Seen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Last_Seen)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_LaunchDXPFromExplorer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_LaunchDXPFromExplorer)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsLocalMachine(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsLocalMachine)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Manufacturer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Manufacturer)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_MissedCalls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_MissedCalls)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_ModelName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_ModelName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_NetworkName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_NetworkName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_NetworkType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_NetworkType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_NewPictures(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_NewPictures)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Notification(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Notification)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Notification_LowBattery(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Notification_LowBattery)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Notification_MissedCall(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Notification_MissedCall)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Notification_NewMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Notification_NewMessage)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Notification_NewVoicemail(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Notification_NewVoicemail)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Notification_StorageFull(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Notification_StorageFull)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Notification_StorageFullLinkText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Notification_StorageFullLinkText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_NotificationStore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_NotificationStore)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsNotWorkingProperly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsNotWorkingProperly)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_IsPaired(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_IsPaired)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_PrimaryCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_PrimaryCategory)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Roaming(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Roaming)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_SafeRemovalRequired(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_SafeRemovalRequired)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_SignalStrength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_SignalStrength)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Status1(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Status1)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Status2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Status2)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_StorageCapacity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_StorageCapacity)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_StorageFreeSpace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_StorageFreeSpace)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_StorageFreeSpacePercent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_StorageFreeSpacePercent)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_TextMessages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_TextMessages)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Version(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Version)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Devices_Voicemail(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Devices_Voicemail)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_ByteCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_ByteCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_CharacterCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_CharacterCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_ClientID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_ClientID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_Contributor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_Contributor)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_DateCreated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_DateCreated)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_DatePrinted(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_DatePrinted)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_DateSaved(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_DateSaved)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_Division(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_Division)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_DocumentID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_DocumentID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_HiddenSlideCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_HiddenSlideCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_LastAuthor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_LastAuthor)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_LineCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_LineCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_Manager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_Manager)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_MultimediaClipCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_MultimediaClipCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_NoteCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_NoteCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_PageCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_PageCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_ParagraphCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_ParagraphCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_PresentationFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_PresentationFormat)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_RevisionNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_RevisionNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_Security(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_Security)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_SlideCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_SlideCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_Template(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_Template)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_TotalEditingTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_TotalEditingTime)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_Version(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_Version)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Document_WordCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Document_WordCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DRM_DatePlayExpires(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DRM_DatePlayExpires)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DRM_DatePlayStarts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DRM_DatePlayStarts)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DRM_Description(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DRM_Description)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DRM_IsProtected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DRM_IsProtected)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DRM_PlayCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DRM_PlayCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Altitude(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Altitude)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_AltitudeDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_AltitudeDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_AltitudeNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_AltitudeNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_AltitudeRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_AltitudeRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_AreaInformation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_AreaInformation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Date(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Date)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestBearing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestBearing)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestBearingDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestBearingDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestBearingNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestBearingNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestBearingRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestBearingRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestDistance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestDistance)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestDistanceDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestDistanceDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestDistanceNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestDistanceNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestDistanceRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestDistanceRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestLatitude(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestLatitude)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestLatitudeDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestLatitudeDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestLatitudeNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestLatitudeNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestLatitudeRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestLatitudeRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestLongitude(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestLongitude)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestLongitudeDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestLongitudeDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestLongitudeNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestLongitudeNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DestLongitudeRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DestLongitudeRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Differential(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Differential)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DOP(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DOP)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DOPDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DOPDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_DOPNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_DOPNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_ImgDirection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_ImgDirection)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_ImgDirectionDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_ImgDirectionDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_ImgDirectionNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_ImgDirectionNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_ImgDirectionRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_ImgDirectionRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Latitude(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Latitude)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_LatitudeDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_LatitudeDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_LatitudeNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_LatitudeNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_LatitudeRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_LatitudeRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Longitude(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Longitude)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_LongitudeDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_LongitudeDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_LongitudeNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_LongitudeNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_LongitudeRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_LongitudeRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_MapDatum(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_MapDatum)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_MeasureMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_MeasureMode)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_ProcessingMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_ProcessingMethod)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Satellites(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Satellites)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Speed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Speed)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_SpeedDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_SpeedDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_SpeedNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_SpeedNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_SpeedRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_SpeedRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Status(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Status)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_Track(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_Track)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_TrackDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_TrackDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_TrackNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_TrackNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_TrackRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_TrackRef)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_GPS_VersionID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_GPS_VersionID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_BitDepth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_BitDepth)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_ColorSpace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_ColorSpace)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_CompressedBitsPerPixel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_CompressedBitsPerPixel)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_CompressedBitsPerPixelDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_CompressedBitsPerPixelDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_CompressedBitsPerPixelNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_CompressedBitsPerPixelNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_Compression(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_Compression)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_CompressionText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_CompressionText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_Dimensions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_Dimensions)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_HorizontalResolution(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_HorizontalResolution)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_HorizontalSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_HorizontalSize)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_ImageID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_ImageID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_ResolutionUnit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_ResolutionUnit)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_VerticalResolution(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_VerticalResolution)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Image_VerticalSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Image_VerticalSize)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Journal_Contacts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Journal_Contacts)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Journal_EntryType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Journal_EntryType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_LayoutPattern_ContentViewModeForBrowse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_LayoutPattern_ContentViewModeForBrowse)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_LayoutPattern_ContentViewModeForSearch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_LayoutPattern_ContentViewModeForSearch)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_Arguments(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_Arguments)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_Comment(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_Comment)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_DateVisited(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_DateVisited)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_Description(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_Description)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_Status(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_Status)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_TargetExtension(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_TargetExtension)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_TargetParsingPath(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_TargetParsingPath)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_TargetSFGAOFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_TargetSFGAOFlags)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_AuthorUrl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_AuthorUrl)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_AverageLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_AverageLevel)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_ClassPrimaryID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_ClassPrimaryID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_ClassSecondaryID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_ClassSecondaryID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_CollectionGroupID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_CollectionGroupID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_CollectionID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_CollectionID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_ContentDistributor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_ContentDistributor)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_ContentID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_ContentID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_CreatorApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_CreatorApplication)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_CreatorApplicationVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_CreatorApplicationVersion)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_DateEncoded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_DateEncoded)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_DateReleased(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_DateReleased)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_Duration(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_Duration)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_DVDID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_DVDID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_EncodedBy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_EncodedBy)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_EncodingSettings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_EncodingSettings)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_FrameCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_FrameCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_MCDI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_MCDI)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_MetadataContentProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_MetadataContentProvider)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_Producer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_Producer)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_PromotionUrl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_PromotionUrl)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_ProtectionType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_ProtectionType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_ProviderRating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_ProviderRating)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_ProviderStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_ProviderStyle)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_Publisher(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_Publisher)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_SubscriptionContentId(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_SubscriptionContentId)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_SubTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_SubTitle)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_UniqueFileIdentifier(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_UniqueFileIdentifier)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_UserNoAutoInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_UserNoAutoInfo)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_UserWebUrl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_UserWebUrl)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_Writer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_Writer)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Media_Year(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Media_Year)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_AttachmentContents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_AttachmentContents)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_AttachmentNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_AttachmentNames)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_BccAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_BccAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_BccName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_BccName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_CcAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_CcAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_CcName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_CcName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_ConversationID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_ConversationID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_ConversationIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_ConversationIndex)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_DateReceived(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_DateReceived)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_DateSent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_DateSent)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_Flags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_Flags)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_FromAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_FromAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_FromName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_FromName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_HasAttachments(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_HasAttachments)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_IsFwdOrReply(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_IsFwdOrReply)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_MessageClass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_MessageClass)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_ProofInProgress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_ProofInProgress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_SenderAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_SenderAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_SenderName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_SenderName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_Store(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_Store)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_ToAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_ToAddress)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_ToDoFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_ToDoFlags)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_ToDoTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_ToDoTitle)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Message_ToName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Message_ToName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_AlbumArtist(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_AlbumArtist)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_AlbumID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_AlbumID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_AlbumTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_AlbumTitle)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_Artist(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_Artist)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_BeatsPerMinute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_BeatsPerMinute)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_Composer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_Composer)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_Conductor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_Conductor)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_ContentGroupDescription(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_ContentGroupDescription)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_Genre(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_Genre)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_InitialKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_InitialKey)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_Lyrics(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_Lyrics)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_Mood(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_Mood)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_PartOfSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_PartOfSet)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_Period(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_Period)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_SynchronizedLyrics(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_SynchronizedLyrics)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Music_TrackNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Music_TrackNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Note_Color(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Note_Color)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Note_ColorText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Note_ColorText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_Aperture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_Aperture)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ApertureDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ApertureDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ApertureNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ApertureNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_Brightness(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_Brightness)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_BrightnessDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_BrightnessDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_BrightnessNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_BrightnessNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_CameraManufacturer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_CameraManufacturer)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_CameraModel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_CameraModel)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_CameraSerialNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_CameraSerialNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_Contrast(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_Contrast)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ContrastText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ContrastText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_DateTaken(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_DateTaken)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_DigitalZoom(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_DigitalZoom)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_DigitalZoomDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_DigitalZoomDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_DigitalZoomNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_DigitalZoomNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_Event(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_Event)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_EXIFVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_EXIFVersion)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureBias(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureBias)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureBiasDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureBiasDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureBiasNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureBiasNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureIndex)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureIndexDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureIndexDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureIndexNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureIndexNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureProgram(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureProgram)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureProgramText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureProgramText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureTime)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureTimeDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureTimeDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ExposureTimeNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ExposureTimeNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_Flash(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_Flash)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FlashEnergy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FlashEnergy)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FlashEnergyDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FlashEnergyDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FlashEnergyNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FlashEnergyNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FlashManufacturer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FlashManufacturer)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FlashModel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FlashModel)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FlashText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FlashText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FNumberDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FNumberDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FNumberNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FNumberNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalLength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalLength)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalLengthDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalLengthDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalLengthInFilm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalLengthInFilm)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalLengthNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalLengthNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalPlaneXResolution(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalPlaneXResolution)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalPlaneXResolutionDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalPlaneXResolutionDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalPlaneXResolutionNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalPlaneXResolutionNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalPlaneYResolution(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalPlaneYResolution)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalPlaneYResolutionDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalPlaneYResolutionDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_FocalPlaneYResolutionNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_FocalPlaneYResolutionNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_GainControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_GainControl)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_GainControlDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_GainControlDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_GainControlNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_GainControlNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_GainControlText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_GainControlText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ISOSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ISOSpeed)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_LensManufacturer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_LensManufacturer)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_LensModel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_LensModel)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_LightSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_LightSource)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_MakerNote(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_MakerNote)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_MakerNoteOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_MakerNoteOffset)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_MaxAperture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_MaxAperture)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_MaxApertureDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_MaxApertureDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_MaxApertureNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_MaxApertureNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_MeteringMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_MeteringMode)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_MeteringModeText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_MeteringModeText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_Orientation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_Orientation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_OrientationText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_OrientationText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_PeopleNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_PeopleNames)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_PhotometricInterpretation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_PhotometricInterpretation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_PhotometricInterpretationText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_PhotometricInterpretationText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ProgramMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ProgramMode)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ProgramModeText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ProgramModeText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_RelatedSoundFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_RelatedSoundFile)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_Saturation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_Saturation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_SaturationText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_SaturationText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_Sharpness(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_Sharpness)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_SharpnessText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_SharpnessText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ShutterSpeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ShutterSpeed)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ShutterSpeedDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ShutterSpeedDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_ShutterSpeedNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_ShutterSpeedNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_SubjectDistance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_SubjectDistance)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_SubjectDistanceDenominator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_SubjectDistanceDenominator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_SubjectDistanceNumerator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_SubjectDistanceNumerator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_TagViewAggregate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_TagViewAggregate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_TranscodedForSync(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_TranscodedForSync)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_WhiteBalance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_WhiteBalance)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Photo_WhiteBalanceText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Photo_WhiteBalanceText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Advanced(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Advanced)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Audio(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Audio)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Calendar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Calendar)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Camera(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Camera)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Contact(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Contact)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Content(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Content)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Description(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Description)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_FileSystem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_FileSystem)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_General(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_General)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_GPS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_GPS)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Image(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Image)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Media(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Media)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_MediaAdvanced(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_MediaAdvanced)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Message(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Message)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Music(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Music)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Origin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Origin)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_PhotoAdvanced(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_PhotoAdvanced)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_RecordedTV(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_RecordedTV)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropGroup_Video(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropGroup_Video)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_InfoTipText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_InfoTipText)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_ConflictPrompt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_ConflictPrompt)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_ContentViewModeForBrowse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_ContentViewModeForBrowse)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_ContentViewModeForSearch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_ContentViewModeForSearch)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_ExtendedTileInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_ExtendedTileInfo)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_FileOperationPrompt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_FileOperationPrompt)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_FullDetails(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_FullDetails)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_InfoTip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_InfoTip)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_NonPersonal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_NonPersonal)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_PreviewDetails(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_PreviewDetails)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_PreviewTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_PreviewTitle)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_QuickTip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_QuickTip)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_TileInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_TileInfo)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_PropList_XPDetailsPanel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_PropList_XPDetailsPanel)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_ChannelNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_ChannelNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_Credits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_Credits)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_DateContentExpires(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_DateContentExpires)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_EpisodeName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_EpisodeName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_IsATSCContent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_IsATSCContent)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_IsClosedCaptioningAvailable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_IsClosedCaptioningAvailable)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_IsDTVContent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_IsDTVContent)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_IsHDContent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_IsHDContent)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_IsRepeatBroadcast(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_IsRepeatBroadcast)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_IsSAP(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_IsSAP)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_NetworkAffiliation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_NetworkAffiliation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_OriginalBroadcastDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_OriginalBroadcastDate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_ProgramDescription(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_ProgramDescription)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_RecordingTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_RecordingTime)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_StationCallSign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_StationCallSign)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_RecordedTV_StationName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_RecordedTV_StationName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_AutoSummary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_AutoSummary)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_ContainerHash(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_ContainerHash)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_Contents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_Contents)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_EntryID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_EntryID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_ExtendedProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_ExtendedProperties)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_GatherTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_GatherTime)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_HitCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_HitCount)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_IsClosedDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_IsClosedDirectory)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_IsFullyContained(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_IsFullyContained)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_QueryFocusedSummary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_QueryFocusedSummary)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_QueryFocusedSummaryWithFallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_QueryFocusedSummaryWithFallback)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_Rank(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_Rank)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_Store(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_Store)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_UrlToIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_UrlToIndex)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Search_UrlToIndexWithModificationTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Search_UrlToIndexWithModificationTime)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_DescriptionID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_DescriptionID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_InternalName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_InternalName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_TargetSFGAOFlagsStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_TargetSFGAOFlagsStrings)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Link_TargetUrl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Link_TargetUrl)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_NamespaceCLSID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_NamespaceCLSID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Shell_SFGAOFlagsStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Shell_SFGAOFlagsStrings)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_AppUserModel_ExcludeFromShowInNewInstall(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_AppUserModel_ExcludeFromShowInNewInstall)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_AppUserModel_ID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_AppUserModel_ID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_AppUserModel_IsDestListSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_AppUserModel_IsDestListSeparator)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_AppUserModel_RelaunchCommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_AppUserModel_RelaunchCommand)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_AppUserModel_RelaunchDisplayNameResource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_AppUserModel_RelaunchDisplayNameResource)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_AppUserModel_RelaunchIconResource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_AppUserModel_RelaunchIconResource)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Software_DateLastUsed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Software_DateLastUsed)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Software_ProductName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Software_ProductName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_Comments(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_Comments)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_ConflictDescription(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_ConflictDescription)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_ConflictFirstLocation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_ConflictFirstLocation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_ConflictSecondLocation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_ConflictSecondLocation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_HandlerCollectionID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_HandlerCollectionID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_HandlerID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_HandlerID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_HandlerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_HandlerName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_HandlerType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_HandlerType)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_HandlerTypeLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_HandlerTypeLabel)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_ItemID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_ItemID)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_ItemName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_ItemName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_ProgressPercentage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_ProgressPercentage)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_State(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_State)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Sync_Status(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Sync_Status)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Task_BillingInformation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Task_BillingInformation)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Task_CompletionStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Task_CompletionStatus)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Task_Owner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Task_Owner)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_Compression(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_Compression)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_Director(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_Director)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_EncodingBitrate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_EncodingBitrate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_FourCC(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_FourCC)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_FrameHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_FrameHeight)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_FrameRate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_FrameRate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_FrameWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_FrameWidth)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_HorizontalAspectRatio(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_HorizontalAspectRatio)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_SampleSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_SampleSize)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_StreamName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_StreamName)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_StreamNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_StreamNumber)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_TotalBitrate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_TotalBitrate)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Video_VerticalAspectRatio(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Video_VerticalAspectRatio)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Volume_FileSystem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Volume_FileSystem)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Volume_IsMappedDrive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Volume_IsMappedDrive)));
  end;
end;

procedure TatPropKeyLibrary.__GetPKEY_Volume_IsRoot(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_tagpropertykeyWrapper.Create(PropKey.PKEY_Volume_IsRoot)));
  end;
end;

procedure TatPropKeyLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('PKEY_Audio_ChannelCount',tkVariant,__GetPKEY_Audio_ChannelCount,nil,nil,false,0);
    DefineProp('PKEY_Audio_Compression',tkVariant,__GetPKEY_Audio_Compression,nil,nil,false,0);
    DefineProp('PKEY_Audio_EncodingBitrate',tkVariant,__GetPKEY_Audio_EncodingBitrate,nil,nil,false,0);
    DefineProp('PKEY_Audio_Format',tkVariant,__GetPKEY_Audio_Format,nil,nil,false,0);
    DefineProp('PKEY_Audio_IsVariableBitRate',tkVariant,__GetPKEY_Audio_IsVariableBitRate,nil,nil,false,0);
    DefineProp('PKEY_Audio_PeakValue',tkVariant,__GetPKEY_Audio_PeakValue,nil,nil,false,0);
    DefineProp('PKEY_Audio_SampleRate',tkVariant,__GetPKEY_Audio_SampleRate,nil,nil,false,0);
    DefineProp('PKEY_Audio_SampleSize',tkVariant,__GetPKEY_Audio_SampleSize,nil,nil,false,0);
    DefineProp('PKEY_Audio_StreamName',tkVariant,__GetPKEY_Audio_StreamName,nil,nil,false,0);
    DefineProp('PKEY_Audio_StreamNumber',tkVariant,__GetPKEY_Audio_StreamNumber,nil,nil,false,0);
    DefineProp('PKEY_Calendar_Duration',tkVariant,__GetPKEY_Calendar_Duration,nil,nil,false,0);
    DefineProp('PKEY_Calendar_IsOnline',tkVariant,__GetPKEY_Calendar_IsOnline,nil,nil,false,0);
    DefineProp('PKEY_Calendar_IsRecurring',tkVariant,__GetPKEY_Calendar_IsRecurring,nil,nil,false,0);
    DefineProp('PKEY_Calendar_Location',tkVariant,__GetPKEY_Calendar_Location,nil,nil,false,0);
    DefineProp('PKEY_Calendar_OptionalAttendeeAddresses',tkVariant,__GetPKEY_Calendar_OptionalAttendeeAddresses,nil,nil,false,0);
    DefineProp('PKEY_Calendar_OptionalAttendeeNames',tkVariant,__GetPKEY_Calendar_OptionalAttendeeNames,nil,nil,false,0);
    DefineProp('PKEY_Calendar_OrganizerAddress',tkVariant,__GetPKEY_Calendar_OrganizerAddress,nil,nil,false,0);
    DefineProp('PKEY_Calendar_OrganizerName',tkVariant,__GetPKEY_Calendar_OrganizerName,nil,nil,false,0);
    DefineProp('PKEY_Calendar_ReminderTime',tkVariant,__GetPKEY_Calendar_ReminderTime,nil,nil,false,0);
    DefineProp('PKEY_Calendar_RequiredAttendeeAddresses',tkVariant,__GetPKEY_Calendar_RequiredAttendeeAddresses,nil,nil,false,0);
    DefineProp('PKEY_Calendar_RequiredAttendeeNames',tkVariant,__GetPKEY_Calendar_RequiredAttendeeNames,nil,nil,false,0);
    DefineProp('PKEY_Calendar_Resources',tkVariant,__GetPKEY_Calendar_Resources,nil,nil,false,0);
    DefineProp('PKEY_Calendar_ResponseStatus',tkVariant,__GetPKEY_Calendar_ResponseStatus,nil,nil,false,0);
    DefineProp('PKEY_Calendar_ShowTimeAs',tkVariant,__GetPKEY_Calendar_ShowTimeAs,nil,nil,false,0);
    DefineProp('PKEY_Calendar_ShowTimeAsText',tkVariant,__GetPKEY_Calendar_ShowTimeAsText,nil,nil,false,0);
    DefineProp('PKEY_Communication_AccountName',tkVariant,__GetPKEY_Communication_AccountName,nil,nil,false,0);
    DefineProp('PKEY_Communication_DateItemExpires',tkVariant,__GetPKEY_Communication_DateItemExpires,nil,nil,false,0);
    DefineProp('PKEY_Communication_FollowupIconIndex',tkVariant,__GetPKEY_Communication_FollowupIconIndex,nil,nil,false,0);
    DefineProp('PKEY_Communication_HeaderItem',tkVariant,__GetPKEY_Communication_HeaderItem,nil,nil,false,0);
    DefineProp('PKEY_Communication_PolicyTag',tkVariant,__GetPKEY_Communication_PolicyTag,nil,nil,false,0);
    DefineProp('PKEY_Communication_SecurityFlags',tkVariant,__GetPKEY_Communication_SecurityFlags,nil,nil,false,0);
    DefineProp('PKEY_Communication_Suffix',tkVariant,__GetPKEY_Communication_Suffix,nil,nil,false,0);
    DefineProp('PKEY_Communication_TaskStatus',tkVariant,__GetPKEY_Communication_TaskStatus,nil,nil,false,0);
    DefineProp('PKEY_Communication_TaskStatusText',tkVariant,__GetPKEY_Communication_TaskStatusText,nil,nil,false,0);
    DefineProp('PKEY_Computer_DecoratedFreeSpace',tkVariant,__GetPKEY_Computer_DecoratedFreeSpace,nil,nil,false,0);
    DefineProp('PKEY_Contact_Anniversary',tkVariant,__GetPKEY_Contact_Anniversary,nil,nil,false,0);
    DefineProp('PKEY_Contact_AssistantName',tkVariant,__GetPKEY_Contact_AssistantName,nil,nil,false,0);
    DefineProp('PKEY_Contact_AssistantTelephone',tkVariant,__GetPKEY_Contact_AssistantTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_Birthday',tkVariant,__GetPKEY_Contact_Birthday,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessAddress',tkVariant,__GetPKEY_Contact_BusinessAddress,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessAddressCity',tkVariant,__GetPKEY_Contact_BusinessAddressCity,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessAddressCountry',tkVariant,__GetPKEY_Contact_BusinessAddressCountry,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessAddressPostalCode',tkVariant,__GetPKEY_Contact_BusinessAddressPostalCode,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessAddressPostOfficeBox',tkVariant,__GetPKEY_Contact_BusinessAddressPostOfficeBox,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessAddressState',tkVariant,__GetPKEY_Contact_BusinessAddressState,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessAddressStreet',tkVariant,__GetPKEY_Contact_BusinessAddressStreet,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessFaxNumber',tkVariant,__GetPKEY_Contact_BusinessFaxNumber,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessHomePage',tkVariant,__GetPKEY_Contact_BusinessHomePage,nil,nil,false,0);
    DefineProp('PKEY_Contact_BusinessTelephone',tkVariant,__GetPKEY_Contact_BusinessTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_CallbackTelephone',tkVariant,__GetPKEY_Contact_CallbackTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_CarTelephone',tkVariant,__GetPKEY_Contact_CarTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_Children',tkVariant,__GetPKEY_Contact_Children,nil,nil,false,0);
    DefineProp('PKEY_Contact_CompanyMainTelephone',tkVariant,__GetPKEY_Contact_CompanyMainTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_Department',tkVariant,__GetPKEY_Contact_Department,nil,nil,false,0);
    DefineProp('PKEY_Contact_EmailAddress',tkVariant,__GetPKEY_Contact_EmailAddress,nil,nil,false,0);
    DefineProp('PKEY_Contact_EmailAddress2',tkVariant,__GetPKEY_Contact_EmailAddress2,nil,nil,false,0);
    DefineProp('PKEY_Contact_EmailAddress3',tkVariant,__GetPKEY_Contact_EmailAddress3,nil,nil,false,0);
    DefineProp('PKEY_Contact_EmailAddresses',tkVariant,__GetPKEY_Contact_EmailAddresses,nil,nil,false,0);
    DefineProp('PKEY_Contact_EmailName',tkVariant,__GetPKEY_Contact_EmailName,nil,nil,false,0);
    DefineProp('PKEY_Contact_FileAsName',tkVariant,__GetPKEY_Contact_FileAsName,nil,nil,false,0);
    DefineProp('PKEY_Contact_FirstName',tkVariant,__GetPKEY_Contact_FirstName,nil,nil,false,0);
    DefineProp('PKEY_Contact_FullName',tkVariant,__GetPKEY_Contact_FullName,nil,nil,false,0);
    DefineProp('PKEY_Contact_Gender',tkVariant,__GetPKEY_Contact_Gender,nil,nil,false,0);
    DefineProp('PKEY_Contact_GenderValue',tkVariant,__GetPKEY_Contact_GenderValue,nil,nil,false,0);
    DefineProp('PKEY_Contact_Hobbies',tkVariant,__GetPKEY_Contact_Hobbies,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeAddress',tkVariant,__GetPKEY_Contact_HomeAddress,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeAddressCity',tkVariant,__GetPKEY_Contact_HomeAddressCity,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeAddressCountry',tkVariant,__GetPKEY_Contact_HomeAddressCountry,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeAddressPostalCode',tkVariant,__GetPKEY_Contact_HomeAddressPostalCode,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeAddressPostOfficeBox',tkVariant,__GetPKEY_Contact_HomeAddressPostOfficeBox,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeAddressState',tkVariant,__GetPKEY_Contact_HomeAddressState,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeAddressStreet',tkVariant,__GetPKEY_Contact_HomeAddressStreet,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeFaxNumber',tkVariant,__GetPKEY_Contact_HomeFaxNumber,nil,nil,false,0);
    DefineProp('PKEY_Contact_HomeTelephone',tkVariant,__GetPKEY_Contact_HomeTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_IMAddress',tkVariant,__GetPKEY_Contact_IMAddress,nil,nil,false,0);
    DefineProp('PKEY_Contact_Initials',tkVariant,__GetPKEY_Contact_Initials,nil,nil,false,0);
    DefineProp('PKEY_Contact_JA_CompanyNamePhonetic',tkVariant,__GetPKEY_Contact_JA_CompanyNamePhonetic,nil,nil,false,0);
    DefineProp('PKEY_Contact_JA_FirstNamePhonetic',tkVariant,__GetPKEY_Contact_JA_FirstNamePhonetic,nil,nil,false,0);
    DefineProp('PKEY_Contact_JA_LastNamePhonetic',tkVariant,__GetPKEY_Contact_JA_LastNamePhonetic,nil,nil,false,0);
    DefineProp('PKEY_Contact_JobTitle',tkVariant,__GetPKEY_Contact_JobTitle,nil,nil,false,0);
    DefineProp('PKEY_Contact_Label',tkVariant,__GetPKEY_Contact_Label,nil,nil,false,0);
    DefineProp('PKEY_Contact_LastName',tkVariant,__GetPKEY_Contact_LastName,nil,nil,false,0);
    DefineProp('PKEY_Contact_MailingAddress',tkVariant,__GetPKEY_Contact_MailingAddress,nil,nil,false,0);
    DefineProp('PKEY_Contact_MiddleName',tkVariant,__GetPKEY_Contact_MiddleName,nil,nil,false,0);
    DefineProp('PKEY_Contact_MobileTelephone',tkVariant,__GetPKEY_Contact_MobileTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_NickName',tkVariant,__GetPKEY_Contact_NickName,nil,nil,false,0);
    DefineProp('PKEY_Contact_OfficeLocation',tkVariant,__GetPKEY_Contact_OfficeLocation,nil,nil,false,0);
    DefineProp('PKEY_Contact_OtherAddress',tkVariant,__GetPKEY_Contact_OtherAddress,nil,nil,false,0);
    DefineProp('PKEY_Contact_OtherAddressCity',tkVariant,__GetPKEY_Contact_OtherAddressCity,nil,nil,false,0);
    DefineProp('PKEY_Contact_OtherAddressCountry',tkVariant,__GetPKEY_Contact_OtherAddressCountry,nil,nil,false,0);
    DefineProp('PKEY_Contact_OtherAddressPostalCode',tkVariant,__GetPKEY_Contact_OtherAddressPostalCode,nil,nil,false,0);
    DefineProp('PKEY_Contact_OtherAddressPostOfficeBox',tkVariant,__GetPKEY_Contact_OtherAddressPostOfficeBox,nil,nil,false,0);
    DefineProp('PKEY_Contact_OtherAddressState',tkVariant,__GetPKEY_Contact_OtherAddressState,nil,nil,false,0);
    DefineProp('PKEY_Contact_OtherAddressStreet',tkVariant,__GetPKEY_Contact_OtherAddressStreet,nil,nil,false,0);
    DefineProp('PKEY_Contact_PagerTelephone',tkVariant,__GetPKEY_Contact_PagerTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_PersonalTitle',tkVariant,__GetPKEY_Contact_PersonalTitle,nil,nil,false,0);
    DefineProp('PKEY_Contact_PrimaryAddressCity',tkVariant,__GetPKEY_Contact_PrimaryAddressCity,nil,nil,false,0);
    DefineProp('PKEY_Contact_PrimaryAddressCountry',tkVariant,__GetPKEY_Contact_PrimaryAddressCountry,nil,nil,false,0);
    DefineProp('PKEY_Contact_PrimaryAddressPostalCode',tkVariant,__GetPKEY_Contact_PrimaryAddressPostalCode,nil,nil,false,0);
    DefineProp('PKEY_Contact_PrimaryAddressPostOfficeBox',tkVariant,__GetPKEY_Contact_PrimaryAddressPostOfficeBox,nil,nil,false,0);
    DefineProp('PKEY_Contact_PrimaryAddressState',tkVariant,__GetPKEY_Contact_PrimaryAddressState,nil,nil,false,0);
    DefineProp('PKEY_Contact_PrimaryAddressStreet',tkVariant,__GetPKEY_Contact_PrimaryAddressStreet,nil,nil,false,0);
    DefineProp('PKEY_Contact_PrimaryEmailAddress',tkVariant,__GetPKEY_Contact_PrimaryEmailAddress,nil,nil,false,0);
    DefineProp('PKEY_Contact_PrimaryTelephone',tkVariant,__GetPKEY_Contact_PrimaryTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_Profession',tkVariant,__GetPKEY_Contact_Profession,nil,nil,false,0);
    DefineProp('PKEY_Contact_SpouseName',tkVariant,__GetPKEY_Contact_SpouseName,nil,nil,false,0);
    DefineProp('PKEY_Contact_Suffix',tkVariant,__GetPKEY_Contact_Suffix,nil,nil,false,0);
    DefineProp('PKEY_Contact_TelexNumber',tkVariant,__GetPKEY_Contact_TelexNumber,nil,nil,false,0);
    DefineProp('PKEY_Contact_TTYTDDTelephone',tkVariant,__GetPKEY_Contact_TTYTDDTelephone,nil,nil,false,0);
    DefineProp('PKEY_Contact_WebPage',tkVariant,__GetPKEY_Contact_WebPage,nil,nil,false,0);
    DefineProp('PKEY_AcquisitionID',tkVariant,__GetPKEY_AcquisitionID,nil,nil,false,0);
    DefineProp('PKEY_ApplicationName',tkVariant,__GetPKEY_ApplicationName,nil,nil,false,0);
    DefineProp('PKEY_Author',tkVariant,__GetPKEY_Author,nil,nil,false,0);
    DefineProp('PKEY_Capacity',tkVariant,__GetPKEY_Capacity,nil,nil,false,0);
    DefineProp('PKEY_Category',tkVariant,__GetPKEY_Category,nil,nil,false,0);
    DefineProp('PKEY_Comment',tkVariant,__GetPKEY_Comment,nil,nil,false,0);
    DefineProp('PKEY_Company',tkVariant,__GetPKEY_Company,nil,nil,false,0);
    DefineProp('PKEY_ComputerName',tkVariant,__GetPKEY_ComputerName,nil,nil,false,0);
    DefineProp('PKEY_ContainedItems',tkVariant,__GetPKEY_ContainedItems,nil,nil,false,0);
    DefineProp('PKEY_ContentStatus',tkVariant,__GetPKEY_ContentStatus,nil,nil,false,0);
    DefineProp('PKEY_ContentType',tkVariant,__GetPKEY_ContentType,nil,nil,false,0);
    DefineProp('PKEY_Copyright',tkVariant,__GetPKEY_Copyright,nil,nil,false,0);
    DefineProp('PKEY_DateAccessed',tkVariant,__GetPKEY_DateAccessed,nil,nil,false,0);
    DefineProp('PKEY_DateAcquired',tkVariant,__GetPKEY_DateAcquired,nil,nil,false,0);
    DefineProp('PKEY_DateArchived',tkVariant,__GetPKEY_DateArchived,nil,nil,false,0);
    DefineProp('PKEY_DateCompleted',tkVariant,__GetPKEY_DateCompleted,nil,nil,false,0);
    DefineProp('PKEY_DateCreated',tkVariant,__GetPKEY_DateCreated,nil,nil,false,0);
    DefineProp('PKEY_DateImported',tkVariant,__GetPKEY_DateImported,nil,nil,false,0);
    DefineProp('PKEY_DateModified',tkVariant,__GetPKEY_DateModified,nil,nil,false,0);
    DefineProp('PKEY_DueDate',tkVariant,__GetPKEY_DueDate,nil,nil,false,0);
    DefineProp('PKEY_EndDate',tkVariant,__GetPKEY_EndDate,nil,nil,false,0);
    DefineProp('PKEY_FileAllocationSize',tkVariant,__GetPKEY_FileAllocationSize,nil,nil,false,0);
    DefineProp('PKEY_FileAttributes',tkVariant,__GetPKEY_FileAttributes,nil,nil,false,0);
    DefineProp('PKEY_FileCount',tkVariant,__GetPKEY_FileCount,nil,nil,false,0);
    DefineProp('PKEY_FileDescription',tkVariant,__GetPKEY_FileDescription,nil,nil,false,0);
    DefineProp('PKEY_FileExtension',tkVariant,__GetPKEY_FileExtension,nil,nil,false,0);
    DefineProp('PKEY_FileFRN',tkVariant,__GetPKEY_FileFRN,nil,nil,false,0);
    DefineProp('PKEY_FileName',tkVariant,__GetPKEY_FileName,nil,nil,false,0);
    DefineProp('PKEY_FileOwner',tkVariant,__GetPKEY_FileOwner,nil,nil,false,0);
    DefineProp('PKEY_FileVersion',tkVariant,__GetPKEY_FileVersion,nil,nil,false,0);
    DefineProp('PKEY_FindData',tkVariant,__GetPKEY_FindData,nil,nil,false,0);
    DefineProp('PKEY_FlagColor',tkVariant,__GetPKEY_FlagColor,nil,nil,false,0);
    DefineProp('PKEY_FlagColorText',tkVariant,__GetPKEY_FlagColorText,nil,nil,false,0);
    DefineProp('PKEY_FlagStatus',tkVariant,__GetPKEY_FlagStatus,nil,nil,false,0);
    DefineProp('PKEY_FlagStatusText',tkVariant,__GetPKEY_FlagStatusText,nil,nil,false,0);
    DefineProp('PKEY_FreeSpace',tkVariant,__GetPKEY_FreeSpace,nil,nil,false,0);
    DefineProp('PKEY_FullText',tkVariant,__GetPKEY_FullText,nil,nil,false,0);
    DefineProp('PKEY_Identity',tkVariant,__GetPKEY_Identity,nil,nil,false,0);
    DefineProp('PKEY_Identity_Blob',tkVariant,__GetPKEY_Identity_Blob,nil,nil,false,0);
    DefineProp('PKEY_Identity_DisplayName',tkVariant,__GetPKEY_Identity_DisplayName,nil,nil,false,0);
    DefineProp('PKEY_Identity_IsMeIdentity',tkVariant,__GetPKEY_Identity_IsMeIdentity,nil,nil,false,0);
    DefineProp('PKEY_Identity_PrimaryEmailAddress',tkVariant,__GetPKEY_Identity_PrimaryEmailAddress,nil,nil,false,0);
    DefineProp('PKEY_Identity_ProviderID',tkVariant,__GetPKEY_Identity_ProviderID,nil,nil,false,0);
    DefineProp('PKEY_Identity_UniqueID',tkVariant,__GetPKEY_Identity_UniqueID,nil,nil,false,0);
    DefineProp('PKEY_Identity_UserName',tkVariant,__GetPKEY_Identity_UserName,nil,nil,false,0);
    DefineProp('PKEY_IdentityProvider_Name',tkVariant,__GetPKEY_IdentityProvider_Name,nil,nil,false,0);
    DefineProp('PKEY_IdentityProvider_Picture',tkVariant,__GetPKEY_IdentityProvider_Picture,nil,nil,false,0);
    DefineProp('PKEY_ImageParsingName',tkVariant,__GetPKEY_ImageParsingName,nil,nil,false,0);
    DefineProp('PKEY_Importance',tkVariant,__GetPKEY_Importance,nil,nil,false,0);
    DefineProp('PKEY_ImportanceText',tkVariant,__GetPKEY_ImportanceText,nil,nil,false,0);
    DefineProp('PKEY_IsAttachment',tkVariant,__GetPKEY_IsAttachment,nil,nil,false,0);
    DefineProp('PKEY_IsDefaultNonOwnerSaveLocation',tkVariant,__GetPKEY_IsDefaultNonOwnerSaveLocation,nil,nil,false,0);
    DefineProp('PKEY_IsDefaultSaveLocation',tkVariant,__GetPKEY_IsDefaultSaveLocation,nil,nil,false,0);
    DefineProp('PKEY_IsDeleted',tkVariant,__GetPKEY_IsDeleted,nil,nil,false,0);
    DefineProp('PKEY_IsEncrypted',tkVariant,__GetPKEY_IsEncrypted,nil,nil,false,0);
    DefineProp('PKEY_IsFlagged',tkVariant,__GetPKEY_IsFlagged,nil,nil,false,0);
    DefineProp('PKEY_IsFlaggedComplete',tkVariant,__GetPKEY_IsFlaggedComplete,nil,nil,false,0);
    DefineProp('PKEY_IsIncomplete',tkVariant,__GetPKEY_IsIncomplete,nil,nil,false,0);
    DefineProp('PKEY_IsPinnedToNameSpaceTree',tkVariant,__GetPKEY_IsPinnedToNameSpaceTree,nil,nil,false,0);
    DefineProp('PKEY_IsRead',tkVariant,__GetPKEY_IsRead,nil,nil,false,0);
    DefineProp('PKEY_IsSearchOnlyItem',tkVariant,__GetPKEY_IsSearchOnlyItem,nil,nil,false,0);
    DefineProp('PKEY_IsSendToTarget',tkVariant,__GetPKEY_IsSendToTarget,nil,nil,false,0);
    DefineProp('PKEY_IsShared',tkVariant,__GetPKEY_IsShared,nil,nil,false,0);
    DefineProp('PKEY_ItemAuthors',tkVariant,__GetPKEY_ItemAuthors,nil,nil,false,0);
    DefineProp('PKEY_ItemClassType',tkVariant,__GetPKEY_ItemClassType,nil,nil,false,0);
    DefineProp('PKEY_ItemDate',tkVariant,__GetPKEY_ItemDate,nil,nil,false,0);
    DefineProp('PKEY_ItemFolderNameDisplay',tkVariant,__GetPKEY_ItemFolderNameDisplay,nil,nil,false,0);
    DefineProp('PKEY_ItemFolderPathDisplay',tkVariant,__GetPKEY_ItemFolderPathDisplay,nil,nil,false,0);
    DefineProp('PKEY_ItemFolderPathDisplayNarrow',tkVariant,__GetPKEY_ItemFolderPathDisplayNarrow,nil,nil,false,0);
    DefineProp('PKEY_ItemName',tkVariant,__GetPKEY_ItemName,nil,nil,false,0);
    DefineProp('PKEY_ItemNameDisplay',tkVariant,__GetPKEY_ItemNameDisplay,nil,nil,false,0);
    DefineProp('PKEY_ItemNamePrefix',tkVariant,__GetPKEY_ItemNamePrefix,nil,nil,false,0);
    DefineProp('PKEY_ItemParticipants',tkVariant,__GetPKEY_ItemParticipants,nil,nil,false,0);
    DefineProp('PKEY_ItemPathDisplay',tkVariant,__GetPKEY_ItemPathDisplay,nil,nil,false,0);
    DefineProp('PKEY_ItemPathDisplayNarrow',tkVariant,__GetPKEY_ItemPathDisplayNarrow,nil,nil,false,0);
    DefineProp('PKEY_ItemType',tkVariant,__GetPKEY_ItemType,nil,nil,false,0);
    DefineProp('PKEY_ItemTypeText',tkVariant,__GetPKEY_ItemTypeText,nil,nil,false,0);
    DefineProp('PKEY_ItemUrl',tkVariant,__GetPKEY_ItemUrl,nil,nil,false,0);
    DefineProp('PKEY_Keywords',tkVariant,__GetPKEY_Keywords,nil,nil,false,0);
    DefineProp('PKEY_Kind',tkVariant,__GetPKEY_Kind,nil,nil,false,0);
    DefineProp('PKEY_KindText',tkVariant,__GetPKEY_KindText,nil,nil,false,0);
    DefineProp('PKEY_Language',tkVariant,__GetPKEY_Language,nil,nil,false,0);
    DefineProp('PKEY_MileageInformation',tkVariant,__GetPKEY_MileageInformation,nil,nil,false,0);
    DefineProp('PKEY_MIMEType',tkVariant,__GetPKEY_MIMEType,nil,nil,false,0);
    DefineProp('PKEY_Null',tkVariant,__GetPKEY_Null,nil,nil,false,0);
    DefineProp('PKEY_OfflineAvailability',tkVariant,__GetPKEY_OfflineAvailability,nil,nil,false,0);
    DefineProp('PKEY_OfflineStatus',tkVariant,__GetPKEY_OfflineStatus,nil,nil,false,0);
    DefineProp('PKEY_OriginalFileName',tkVariant,__GetPKEY_OriginalFileName,nil,nil,false,0);
    DefineProp('PKEY_OwnerSID',tkVariant,__GetPKEY_OwnerSID,nil,nil,false,0);
    DefineProp('PKEY_ParentalRating',tkVariant,__GetPKEY_ParentalRating,nil,nil,false,0);
    DefineProp('PKEY_ParentalRatingReason',tkVariant,__GetPKEY_ParentalRatingReason,nil,nil,false,0);
    DefineProp('PKEY_ParentalRatingsOrganization',tkVariant,__GetPKEY_ParentalRatingsOrganization,nil,nil,false,0);
    DefineProp('PKEY_ParsingBindContext',tkVariant,__GetPKEY_ParsingBindContext,nil,nil,false,0);
    DefineProp('PKEY_ParsingName',tkVariant,__GetPKEY_ParsingName,nil,nil,false,0);
    DefineProp('PKEY_ParsingPath',tkVariant,__GetPKEY_ParsingPath,nil,nil,false,0);
    DefineProp('PKEY_PerceivedType',tkVariant,__GetPKEY_PerceivedType,nil,nil,false,0);
    DefineProp('PKEY_PercentFull',tkVariant,__GetPKEY_PercentFull,nil,nil,false,0);
    DefineProp('PKEY_Priority',tkVariant,__GetPKEY_Priority,nil,nil,false,0);
    DefineProp('PKEY_PriorityText',tkVariant,__GetPKEY_PriorityText,nil,nil,false,0);
    DefineProp('PKEY_Project',tkVariant,__GetPKEY_Project,nil,nil,false,0);
    DefineProp('PKEY_ProviderItemID',tkVariant,__GetPKEY_ProviderItemID,nil,nil,false,0);
    DefineProp('PKEY_Rating',tkVariant,__GetPKEY_Rating,nil,nil,false,0);
    DefineProp('PKEY_RatingText',tkVariant,__GetPKEY_RatingText,nil,nil,false,0);
    DefineProp('PKEY_Sensitivity',tkVariant,__GetPKEY_Sensitivity,nil,nil,false,0);
    DefineProp('PKEY_SensitivityText',tkVariant,__GetPKEY_SensitivityText,nil,nil,false,0);
    DefineProp('PKEY_SFGAOFlags',tkVariant,__GetPKEY_SFGAOFlags,nil,nil,false,0);
    DefineProp('PKEY_SharedWith',tkVariant,__GetPKEY_SharedWith,nil,nil,false,0);
    DefineProp('PKEY_ShareUserRating',tkVariant,__GetPKEY_ShareUserRating,nil,nil,false,0);
    DefineProp('PKEY_SharingStatus',tkVariant,__GetPKEY_SharingStatus,nil,nil,false,0);
    DefineProp('PKEY_Shell_OmitFromView',tkVariant,__GetPKEY_Shell_OmitFromView,nil,nil,false,0);
    DefineProp('PKEY_SimpleRating',tkVariant,__GetPKEY_SimpleRating,nil,nil,false,0);
    DefineProp('PKEY_Size',tkVariant,__GetPKEY_Size,nil,nil,false,0);
    DefineProp('PKEY_SoftwareUsed',tkVariant,__GetPKEY_SoftwareUsed,nil,nil,false,0);
    DefineProp('PKEY_SourceItem',tkVariant,__GetPKEY_SourceItem,nil,nil,false,0);
    DefineProp('PKEY_StartDate',tkVariant,__GetPKEY_StartDate,nil,nil,false,0);
    DefineProp('PKEY_Status',tkVariant,__GetPKEY_Status,nil,nil,false,0);
    DefineProp('PKEY_Subject',tkVariant,__GetPKEY_Subject,nil,nil,false,0);
    DefineProp('PKEY_Thumbnail',tkVariant,__GetPKEY_Thumbnail,nil,nil,false,0);
    DefineProp('PKEY_ThumbnailCacheId',tkVariant,__GetPKEY_ThumbnailCacheId,nil,nil,false,0);
    DefineProp('PKEY_ThumbnailStream',tkVariant,__GetPKEY_ThumbnailStream,nil,nil,false,0);
    DefineProp('PKEY_Title',tkVariant,__GetPKEY_Title,nil,nil,false,0);
    DefineProp('PKEY_TotalFileSize',tkVariant,__GetPKEY_TotalFileSize,nil,nil,false,0);
    DefineProp('PKEY_Trademarks',tkVariant,__GetPKEY_Trademarks,nil,nil,false,0);
    DefineProp('PKEY_DeviceInterface_PrinterDriverName',tkVariant,__GetPKEY_DeviceInterface_PrinterDriverName,nil,nil,false,0);
    DefineProp('PKEY_DeviceInterface_PrinterName',tkVariant,__GetPKEY_DeviceInterface_PrinterName,nil,nil,false,0);
    DefineProp('PKEY_DeviceInterface_PrinterPortName',tkVariant,__GetPKEY_DeviceInterface_PrinterPortName,nil,nil,false,0);
    DefineProp('PKEY_Devices_Address',tkVariant,__GetPKEY_Devices_Address,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsAuthenticated',tkVariant,__GetPKEY_Devices_IsAuthenticated,nil,nil,false,0);
    DefineProp('PKEY_Devices_BatteryLife',tkVariant,__GetPKEY_Devices_BatteryLife,nil,nil,false,0);
    DefineProp('PKEY_Devices_BatteryPlusCharging',tkVariant,__GetPKEY_Devices_BatteryPlusCharging,nil,nil,false,0);
    DefineProp('PKEY_Devices_BatteryPlusChargingText',tkVariant,__GetPKEY_Devices_BatteryPlusChargingText,nil,nil,false,0);
    DefineProp('PKEY_Devices_Category_Desc_Singular',tkVariant,__GetPKEY_Devices_Category_Desc_Singular,nil,nil,false,0);
    DefineProp('PKEY_Devices_CategoryGroup_Desc',tkVariant,__GetPKEY_Devices_CategoryGroup_Desc,nil,nil,false,0);
    DefineProp('PKEY_Devices_Category_Desc_Plural',tkVariant,__GetPKEY_Devices_Category_Desc_Plural,nil,nil,false,0);
    DefineProp('PKEY_Devices_ChargingState',tkVariant,__GetPKEY_Devices_ChargingState,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsConnected',tkVariant,__GetPKEY_Devices_IsConnected,nil,nil,false,0);
    DefineProp('PKEY_Devices_ContainerId',tkVariant,__GetPKEY_Devices_ContainerId,nil,nil,false,0);
    DefineProp('PKEY_Devices_DeviceConnected',tkVariant,__GetPKEY_Devices_DeviceConnected,nil,nil,false,0);
    DefineProp('PKEY_Devices_DeviceDescription1',tkVariant,__GetPKEY_Devices_DeviceDescription1,nil,nil,false,0);
    DefineProp('PKEY_Devices_DeviceDescription2',tkVariant,__GetPKEY_Devices_DeviceDescription2,nil,nil,false,0);
    DefineProp('PKEY_Devices_DeviceNetworkBytesReceived',tkVariant,__GetPKEY_Devices_DeviceNetworkBytesReceived,nil,nil,false,0);
    DefineProp('PKEY_Devices_DeviceNetworkBytesSent',tkVariant,__GetPKEY_Devices_DeviceNetworkBytesSent,nil,nil,false,0);
    DefineProp('PKEY_Devices_DeviceNetworkConnection',tkVariant,__GetPKEY_Devices_DeviceNetworkConnection,nil,nil,false,0);
    DefineProp('PKEY_Devices_DeviceNetworkConnectionName',tkVariant,__GetPKEY_Devices_DeviceNetworkConnectionName,nil,nil,false,0);
    DefineProp('PKEY_Devices_DeviceNetworkUptime',tkVariant,__GetPKEY_Devices_DeviceNetworkUptime,nil,nil,false,0);
    DefineProp('PKEY_Devices_DiscoveryMethod',tkVariant,__GetPKEY_Devices_DiscoveryMethod,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsEncrypted',tkVariant,__GetPKEY_Devices_IsEncrypted,nil,nil,false,0);
    DefineProp('PKEY_Devices_FriendlyName',tkVariant,__GetPKEY_Devices_FriendlyName,nil,nil,false,0);
    DefineProp('PKEY_Devices_FunctionPaths',tkVariant,__GetPKEY_Devices_FunctionPaths,nil,nil,false,0);
    DefineProp('PKEY_Devices_InterfacePaths',tkVariant,__GetPKEY_Devices_InterfacePaths,nil,nil,false,0);
    DefineProp('PKEY_Devices_InternetConnected',tkVariant,__GetPKEY_Devices_InternetConnected,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsDefaultDevice',tkVariant,__GetPKEY_Devices_IsDefaultDevice,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsNetworkDevice',tkVariant,__GetPKEY_Devices_IsNetworkDevice,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsSharedDevice',tkVariant,__GetPKEY_Devices_IsSharedDevice,nil,nil,false,0);
    DefineProp('PKEY_Devices_Last_Connected',tkVariant,__GetPKEY_Devices_Last_Connected,nil,nil,false,0);
    DefineProp('PKEY_Devices_Last_Seen',tkVariant,__GetPKEY_Devices_Last_Seen,nil,nil,false,0);
    DefineProp('PKEY_Devices_LaunchDXPFromExplorer',tkVariant,__GetPKEY_Devices_LaunchDXPFromExplorer,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsLocalMachine',tkVariant,__GetPKEY_Devices_IsLocalMachine,nil,nil,false,0);
    DefineProp('PKEY_Devices_Manufacturer',tkVariant,__GetPKEY_Devices_Manufacturer,nil,nil,false,0);
    DefineProp('PKEY_Devices_MissedCalls',tkVariant,__GetPKEY_Devices_MissedCalls,nil,nil,false,0);
    DefineProp('PKEY_Devices_ModelName',tkVariant,__GetPKEY_Devices_ModelName,nil,nil,false,0);
    DefineProp('PKEY_Devices_NetworkName',tkVariant,__GetPKEY_Devices_NetworkName,nil,nil,false,0);
    DefineProp('PKEY_Devices_NetworkType',tkVariant,__GetPKEY_Devices_NetworkType,nil,nil,false,0);
    DefineProp('PKEY_Devices_NewPictures',tkVariant,__GetPKEY_Devices_NewPictures,nil,nil,false,0);
    DefineProp('PKEY_Devices_Notification',tkVariant,__GetPKEY_Devices_Notification,nil,nil,false,0);
    DefineProp('PKEY_Devices_Notification_LowBattery',tkVariant,__GetPKEY_Devices_Notification_LowBattery,nil,nil,false,0);
    DefineProp('PKEY_Devices_Notification_MissedCall',tkVariant,__GetPKEY_Devices_Notification_MissedCall,nil,nil,false,0);
    DefineProp('PKEY_Devices_Notification_NewMessage',tkVariant,__GetPKEY_Devices_Notification_NewMessage,nil,nil,false,0);
    DefineProp('PKEY_Devices_Notification_NewVoicemail',tkVariant,__GetPKEY_Devices_Notification_NewVoicemail,nil,nil,false,0);
    DefineProp('PKEY_Devices_Notification_StorageFull',tkVariant,__GetPKEY_Devices_Notification_StorageFull,nil,nil,false,0);
    DefineProp('PKEY_Devices_Notification_StorageFullLinkText',tkVariant,__GetPKEY_Devices_Notification_StorageFullLinkText,nil,nil,false,0);
    DefineProp('PKEY_Devices_NotificationStore',tkVariant,__GetPKEY_Devices_NotificationStore,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsNotWorkingProperly',tkVariant,__GetPKEY_Devices_IsNotWorkingProperly,nil,nil,false,0);
    DefineProp('PKEY_Devices_IsPaired',tkVariant,__GetPKEY_Devices_IsPaired,nil,nil,false,0);
    DefineProp('PKEY_Devices_PrimaryCategory',tkVariant,__GetPKEY_Devices_PrimaryCategory,nil,nil,false,0);
    DefineProp('PKEY_Devices_Roaming',tkVariant,__GetPKEY_Devices_Roaming,nil,nil,false,0);
    DefineProp('PKEY_Devices_SafeRemovalRequired',tkVariant,__GetPKEY_Devices_SafeRemovalRequired,nil,nil,false,0);
    DefineProp('PKEY_Devices_SignalStrength',tkVariant,__GetPKEY_Devices_SignalStrength,nil,nil,false,0);
    DefineProp('PKEY_Devices_Status1',tkVariant,__GetPKEY_Devices_Status1,nil,nil,false,0);
    DefineProp('PKEY_Devices_Status2',tkVariant,__GetPKEY_Devices_Status2,nil,nil,false,0);
    DefineProp('PKEY_Devices_StorageCapacity',tkVariant,__GetPKEY_Devices_StorageCapacity,nil,nil,false,0);
    DefineProp('PKEY_Devices_StorageFreeSpace',tkVariant,__GetPKEY_Devices_StorageFreeSpace,nil,nil,false,0);
    DefineProp('PKEY_Devices_StorageFreeSpacePercent',tkVariant,__GetPKEY_Devices_StorageFreeSpacePercent,nil,nil,false,0);
    DefineProp('PKEY_Devices_TextMessages',tkVariant,__GetPKEY_Devices_TextMessages,nil,nil,false,0);
    DefineProp('PKEY_Devices_Version',tkVariant,__GetPKEY_Devices_Version,nil,nil,false,0);
    DefineProp('PKEY_Devices_Voicemail',tkVariant,__GetPKEY_Devices_Voicemail,nil,nil,false,0);
    DefineProp('PKEY_Document_ByteCount',tkVariant,__GetPKEY_Document_ByteCount,nil,nil,false,0);
    DefineProp('PKEY_Document_CharacterCount',tkVariant,__GetPKEY_Document_CharacterCount,nil,nil,false,0);
    DefineProp('PKEY_Document_ClientID',tkVariant,__GetPKEY_Document_ClientID,nil,nil,false,0);
    DefineProp('PKEY_Document_Contributor',tkVariant,__GetPKEY_Document_Contributor,nil,nil,false,0);
    DefineProp('PKEY_Document_DateCreated',tkVariant,__GetPKEY_Document_DateCreated,nil,nil,false,0);
    DefineProp('PKEY_Document_DatePrinted',tkVariant,__GetPKEY_Document_DatePrinted,nil,nil,false,0);
    DefineProp('PKEY_Document_DateSaved',tkVariant,__GetPKEY_Document_DateSaved,nil,nil,false,0);
    DefineProp('PKEY_Document_Division',tkVariant,__GetPKEY_Document_Division,nil,nil,false,0);
    DefineProp('PKEY_Document_DocumentID',tkVariant,__GetPKEY_Document_DocumentID,nil,nil,false,0);
    DefineProp('PKEY_Document_HiddenSlideCount',tkVariant,__GetPKEY_Document_HiddenSlideCount,nil,nil,false,0);
    DefineProp('PKEY_Document_LastAuthor',tkVariant,__GetPKEY_Document_LastAuthor,nil,nil,false,0);
    DefineProp('PKEY_Document_LineCount',tkVariant,__GetPKEY_Document_LineCount,nil,nil,false,0);
    DefineProp('PKEY_Document_Manager',tkVariant,__GetPKEY_Document_Manager,nil,nil,false,0);
    DefineProp('PKEY_Document_MultimediaClipCount',tkVariant,__GetPKEY_Document_MultimediaClipCount,nil,nil,false,0);
    DefineProp('PKEY_Document_NoteCount',tkVariant,__GetPKEY_Document_NoteCount,nil,nil,false,0);
    DefineProp('PKEY_Document_PageCount',tkVariant,__GetPKEY_Document_PageCount,nil,nil,false,0);
    DefineProp('PKEY_Document_ParagraphCount',tkVariant,__GetPKEY_Document_ParagraphCount,nil,nil,false,0);
    DefineProp('PKEY_Document_PresentationFormat',tkVariant,__GetPKEY_Document_PresentationFormat,nil,nil,false,0);
    DefineProp('PKEY_Document_RevisionNumber',tkVariant,__GetPKEY_Document_RevisionNumber,nil,nil,false,0);
    DefineProp('PKEY_Document_Security',tkVariant,__GetPKEY_Document_Security,nil,nil,false,0);
    DefineProp('PKEY_Document_SlideCount',tkVariant,__GetPKEY_Document_SlideCount,nil,nil,false,0);
    DefineProp('PKEY_Document_Template',tkVariant,__GetPKEY_Document_Template,nil,nil,false,0);
    DefineProp('PKEY_Document_TotalEditingTime',tkVariant,__GetPKEY_Document_TotalEditingTime,nil,nil,false,0);
    DefineProp('PKEY_Document_Version',tkVariant,__GetPKEY_Document_Version,nil,nil,false,0);
    DefineProp('PKEY_Document_WordCount',tkVariant,__GetPKEY_Document_WordCount,nil,nil,false,0);
    DefineProp('PKEY_DRM_DatePlayExpires',tkVariant,__GetPKEY_DRM_DatePlayExpires,nil,nil,false,0);
    DefineProp('PKEY_DRM_DatePlayStarts',tkVariant,__GetPKEY_DRM_DatePlayStarts,nil,nil,false,0);
    DefineProp('PKEY_DRM_Description',tkVariant,__GetPKEY_DRM_Description,nil,nil,false,0);
    DefineProp('PKEY_DRM_IsProtected',tkVariant,__GetPKEY_DRM_IsProtected,nil,nil,false,0);
    DefineProp('PKEY_DRM_PlayCount',tkVariant,__GetPKEY_DRM_PlayCount,nil,nil,false,0);
    DefineProp('PKEY_GPS_Altitude',tkVariant,__GetPKEY_GPS_Altitude,nil,nil,false,0);
    DefineProp('PKEY_GPS_AltitudeDenominator',tkVariant,__GetPKEY_GPS_AltitudeDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_AltitudeNumerator',tkVariant,__GetPKEY_GPS_AltitudeNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_AltitudeRef',tkVariant,__GetPKEY_GPS_AltitudeRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_AreaInformation',tkVariant,__GetPKEY_GPS_AreaInformation,nil,nil,false,0);
    DefineProp('PKEY_GPS_Date',tkVariant,__GetPKEY_GPS_Date,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestBearing',tkVariant,__GetPKEY_GPS_DestBearing,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestBearingDenominator',tkVariant,__GetPKEY_GPS_DestBearingDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestBearingNumerator',tkVariant,__GetPKEY_GPS_DestBearingNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestBearingRef',tkVariant,__GetPKEY_GPS_DestBearingRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestDistance',tkVariant,__GetPKEY_GPS_DestDistance,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestDistanceDenominator',tkVariant,__GetPKEY_GPS_DestDistanceDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestDistanceNumerator',tkVariant,__GetPKEY_GPS_DestDistanceNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestDistanceRef',tkVariant,__GetPKEY_GPS_DestDistanceRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestLatitude',tkVariant,__GetPKEY_GPS_DestLatitude,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestLatitudeDenominator',tkVariant,__GetPKEY_GPS_DestLatitudeDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestLatitudeNumerator',tkVariant,__GetPKEY_GPS_DestLatitudeNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestLatitudeRef',tkVariant,__GetPKEY_GPS_DestLatitudeRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestLongitude',tkVariant,__GetPKEY_GPS_DestLongitude,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestLongitudeDenominator',tkVariant,__GetPKEY_GPS_DestLongitudeDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestLongitudeNumerator',tkVariant,__GetPKEY_GPS_DestLongitudeNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DestLongitudeRef',tkVariant,__GetPKEY_GPS_DestLongitudeRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_Differential',tkVariant,__GetPKEY_GPS_Differential,nil,nil,false,0);
    DefineProp('PKEY_GPS_DOP',tkVariant,__GetPKEY_GPS_DOP,nil,nil,false,0);
    DefineProp('PKEY_GPS_DOPDenominator',tkVariant,__GetPKEY_GPS_DOPDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_DOPNumerator',tkVariant,__GetPKEY_GPS_DOPNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_ImgDirection',tkVariant,__GetPKEY_GPS_ImgDirection,nil,nil,false,0);
    DefineProp('PKEY_GPS_ImgDirectionDenominator',tkVariant,__GetPKEY_GPS_ImgDirectionDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_ImgDirectionNumerator',tkVariant,__GetPKEY_GPS_ImgDirectionNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_ImgDirectionRef',tkVariant,__GetPKEY_GPS_ImgDirectionRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_Latitude',tkVariant,__GetPKEY_GPS_Latitude,nil,nil,false,0);
    DefineProp('PKEY_GPS_LatitudeDenominator',tkVariant,__GetPKEY_GPS_LatitudeDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_LatitudeNumerator',tkVariant,__GetPKEY_GPS_LatitudeNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_LatitudeRef',tkVariant,__GetPKEY_GPS_LatitudeRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_Longitude',tkVariant,__GetPKEY_GPS_Longitude,nil,nil,false,0);
    DefineProp('PKEY_GPS_LongitudeDenominator',tkVariant,__GetPKEY_GPS_LongitudeDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_LongitudeNumerator',tkVariant,__GetPKEY_GPS_LongitudeNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_LongitudeRef',tkVariant,__GetPKEY_GPS_LongitudeRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_MapDatum',tkVariant,__GetPKEY_GPS_MapDatum,nil,nil,false,0);
    DefineProp('PKEY_GPS_MeasureMode',tkVariant,__GetPKEY_GPS_MeasureMode,nil,nil,false,0);
    DefineProp('PKEY_GPS_ProcessingMethod',tkVariant,__GetPKEY_GPS_ProcessingMethod,nil,nil,false,0);
    DefineProp('PKEY_GPS_Satellites',tkVariant,__GetPKEY_GPS_Satellites,nil,nil,false,0);
    DefineProp('PKEY_GPS_Speed',tkVariant,__GetPKEY_GPS_Speed,nil,nil,false,0);
    DefineProp('PKEY_GPS_SpeedDenominator',tkVariant,__GetPKEY_GPS_SpeedDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_SpeedNumerator',tkVariant,__GetPKEY_GPS_SpeedNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_SpeedRef',tkVariant,__GetPKEY_GPS_SpeedRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_Status',tkVariant,__GetPKEY_GPS_Status,nil,nil,false,0);
    DefineProp('PKEY_GPS_Track',tkVariant,__GetPKEY_GPS_Track,nil,nil,false,0);
    DefineProp('PKEY_GPS_TrackDenominator',tkVariant,__GetPKEY_GPS_TrackDenominator,nil,nil,false,0);
    DefineProp('PKEY_GPS_TrackNumerator',tkVariant,__GetPKEY_GPS_TrackNumerator,nil,nil,false,0);
    DefineProp('PKEY_GPS_TrackRef',tkVariant,__GetPKEY_GPS_TrackRef,nil,nil,false,0);
    DefineProp('PKEY_GPS_VersionID',tkVariant,__GetPKEY_GPS_VersionID,nil,nil,false,0);
    DefineProp('PKEY_Image_BitDepth',tkVariant,__GetPKEY_Image_BitDepth,nil,nil,false,0);
    DefineProp('PKEY_Image_ColorSpace',tkVariant,__GetPKEY_Image_ColorSpace,nil,nil,false,0);
    DefineProp('PKEY_Image_CompressedBitsPerPixel',tkVariant,__GetPKEY_Image_CompressedBitsPerPixel,nil,nil,false,0);
    DefineProp('PKEY_Image_CompressedBitsPerPixelDenominator',tkVariant,__GetPKEY_Image_CompressedBitsPerPixelDenominator,nil,nil,false,0);
    DefineProp('PKEY_Image_CompressedBitsPerPixelNumerator',tkVariant,__GetPKEY_Image_CompressedBitsPerPixelNumerator,nil,nil,false,0);
    DefineProp('PKEY_Image_Compression',tkVariant,__GetPKEY_Image_Compression,nil,nil,false,0);
    DefineProp('PKEY_Image_CompressionText',tkVariant,__GetPKEY_Image_CompressionText,nil,nil,false,0);
    DefineProp('PKEY_Image_Dimensions',tkVariant,__GetPKEY_Image_Dimensions,nil,nil,false,0);
    DefineProp('PKEY_Image_HorizontalResolution',tkVariant,__GetPKEY_Image_HorizontalResolution,nil,nil,false,0);
    DefineProp('PKEY_Image_HorizontalSize',tkVariant,__GetPKEY_Image_HorizontalSize,nil,nil,false,0);
    DefineProp('PKEY_Image_ImageID',tkVariant,__GetPKEY_Image_ImageID,nil,nil,false,0);
    DefineProp('PKEY_Image_ResolutionUnit',tkVariant,__GetPKEY_Image_ResolutionUnit,nil,nil,false,0);
    DefineProp('PKEY_Image_VerticalResolution',tkVariant,__GetPKEY_Image_VerticalResolution,nil,nil,false,0);
    DefineProp('PKEY_Image_VerticalSize',tkVariant,__GetPKEY_Image_VerticalSize,nil,nil,false,0);
    DefineProp('PKEY_Journal_Contacts',tkVariant,__GetPKEY_Journal_Contacts,nil,nil,false,0);
    DefineProp('PKEY_Journal_EntryType',tkVariant,__GetPKEY_Journal_EntryType,nil,nil,false,0);
    DefineProp('PKEY_LayoutPattern_ContentViewModeForBrowse',tkVariant,__GetPKEY_LayoutPattern_ContentViewModeForBrowse,nil,nil,false,0);
    DefineProp('PKEY_LayoutPattern_ContentViewModeForSearch',tkVariant,__GetPKEY_LayoutPattern_ContentViewModeForSearch,nil,nil,false,0);
    DefineProp('PKEY_Link_Arguments',tkVariant,__GetPKEY_Link_Arguments,nil,nil,false,0);
    DefineProp('PKEY_Link_Comment',tkVariant,__GetPKEY_Link_Comment,nil,nil,false,0);
    DefineProp('PKEY_Link_DateVisited',tkVariant,__GetPKEY_Link_DateVisited,nil,nil,false,0);
    DefineProp('PKEY_Link_Description',tkVariant,__GetPKEY_Link_Description,nil,nil,false,0);
    DefineProp('PKEY_Link_Status',tkVariant,__GetPKEY_Link_Status,nil,nil,false,0);
    DefineProp('PKEY_Link_TargetExtension',tkVariant,__GetPKEY_Link_TargetExtension,nil,nil,false,0);
    DefineProp('PKEY_Link_TargetParsingPath',tkVariant,__GetPKEY_Link_TargetParsingPath,nil,nil,false,0);
    DefineProp('PKEY_Link_TargetSFGAOFlags',tkVariant,__GetPKEY_Link_TargetSFGAOFlags,nil,nil,false,0);
    DefineProp('PKEY_Media_AuthorUrl',tkVariant,__GetPKEY_Media_AuthorUrl,nil,nil,false,0);
    DefineProp('PKEY_Media_AverageLevel',tkVariant,__GetPKEY_Media_AverageLevel,nil,nil,false,0);
    DefineProp('PKEY_Media_ClassPrimaryID',tkVariant,__GetPKEY_Media_ClassPrimaryID,nil,nil,false,0);
    DefineProp('PKEY_Media_ClassSecondaryID',tkVariant,__GetPKEY_Media_ClassSecondaryID,nil,nil,false,0);
    DefineProp('PKEY_Media_CollectionGroupID',tkVariant,__GetPKEY_Media_CollectionGroupID,nil,nil,false,0);
    DefineProp('PKEY_Media_CollectionID',tkVariant,__GetPKEY_Media_CollectionID,nil,nil,false,0);
    DefineProp('PKEY_Media_ContentDistributor',tkVariant,__GetPKEY_Media_ContentDistributor,nil,nil,false,0);
    DefineProp('PKEY_Media_ContentID',tkVariant,__GetPKEY_Media_ContentID,nil,nil,false,0);
    DefineProp('PKEY_Media_CreatorApplication',tkVariant,__GetPKEY_Media_CreatorApplication,nil,nil,false,0);
    DefineProp('PKEY_Media_CreatorApplicationVersion',tkVariant,__GetPKEY_Media_CreatorApplicationVersion,nil,nil,false,0);
    DefineProp('PKEY_Media_DateEncoded',tkVariant,__GetPKEY_Media_DateEncoded,nil,nil,false,0);
    DefineProp('PKEY_Media_DateReleased',tkVariant,__GetPKEY_Media_DateReleased,nil,nil,false,0);
    DefineProp('PKEY_Media_Duration',tkVariant,__GetPKEY_Media_Duration,nil,nil,false,0);
    DefineProp('PKEY_Media_DVDID',tkVariant,__GetPKEY_Media_DVDID,nil,nil,false,0);
    DefineProp('PKEY_Media_EncodedBy',tkVariant,__GetPKEY_Media_EncodedBy,nil,nil,false,0);
    DefineProp('PKEY_Media_EncodingSettings',tkVariant,__GetPKEY_Media_EncodingSettings,nil,nil,false,0);
    DefineProp('PKEY_Media_FrameCount',tkVariant,__GetPKEY_Media_FrameCount,nil,nil,false,0);
    DefineProp('PKEY_Media_MCDI',tkVariant,__GetPKEY_Media_MCDI,nil,nil,false,0);
    DefineProp('PKEY_Media_MetadataContentProvider',tkVariant,__GetPKEY_Media_MetadataContentProvider,nil,nil,false,0);
    DefineProp('PKEY_Media_Producer',tkVariant,__GetPKEY_Media_Producer,nil,nil,false,0);
    DefineProp('PKEY_Media_PromotionUrl',tkVariant,__GetPKEY_Media_PromotionUrl,nil,nil,false,0);
    DefineProp('PKEY_Media_ProtectionType',tkVariant,__GetPKEY_Media_ProtectionType,nil,nil,false,0);
    DefineProp('PKEY_Media_ProviderRating',tkVariant,__GetPKEY_Media_ProviderRating,nil,nil,false,0);
    DefineProp('PKEY_Media_ProviderStyle',tkVariant,__GetPKEY_Media_ProviderStyle,nil,nil,false,0);
    DefineProp('PKEY_Media_Publisher',tkVariant,__GetPKEY_Media_Publisher,nil,nil,false,0);
    DefineProp('PKEY_Media_SubscriptionContentId',tkVariant,__GetPKEY_Media_SubscriptionContentId,nil,nil,false,0);
    DefineProp('PKEY_Media_SubTitle',tkVariant,__GetPKEY_Media_SubTitle,nil,nil,false,0);
    DefineProp('PKEY_Media_UniqueFileIdentifier',tkVariant,__GetPKEY_Media_UniqueFileIdentifier,nil,nil,false,0);
    DefineProp('PKEY_Media_UserNoAutoInfo',tkVariant,__GetPKEY_Media_UserNoAutoInfo,nil,nil,false,0);
    DefineProp('PKEY_Media_UserWebUrl',tkVariant,__GetPKEY_Media_UserWebUrl,nil,nil,false,0);
    DefineProp('PKEY_Media_Writer',tkVariant,__GetPKEY_Media_Writer,nil,nil,false,0);
    DefineProp('PKEY_Media_Year',tkVariant,__GetPKEY_Media_Year,nil,nil,false,0);
    DefineProp('PKEY_Message_AttachmentContents',tkVariant,__GetPKEY_Message_AttachmentContents,nil,nil,false,0);
    DefineProp('PKEY_Message_AttachmentNames',tkVariant,__GetPKEY_Message_AttachmentNames,nil,nil,false,0);
    DefineProp('PKEY_Message_BccAddress',tkVariant,__GetPKEY_Message_BccAddress,nil,nil,false,0);
    DefineProp('PKEY_Message_BccName',tkVariant,__GetPKEY_Message_BccName,nil,nil,false,0);
    DefineProp('PKEY_Message_CcAddress',tkVariant,__GetPKEY_Message_CcAddress,nil,nil,false,0);
    DefineProp('PKEY_Message_CcName',tkVariant,__GetPKEY_Message_CcName,nil,nil,false,0);
    DefineProp('PKEY_Message_ConversationID',tkVariant,__GetPKEY_Message_ConversationID,nil,nil,false,0);
    DefineProp('PKEY_Message_ConversationIndex',tkVariant,__GetPKEY_Message_ConversationIndex,nil,nil,false,0);
    DefineProp('PKEY_Message_DateReceived',tkVariant,__GetPKEY_Message_DateReceived,nil,nil,false,0);
    DefineProp('PKEY_Message_DateSent',tkVariant,__GetPKEY_Message_DateSent,nil,nil,false,0);
    DefineProp('PKEY_Message_Flags',tkVariant,__GetPKEY_Message_Flags,nil,nil,false,0);
    DefineProp('PKEY_Message_FromAddress',tkVariant,__GetPKEY_Message_FromAddress,nil,nil,false,0);
    DefineProp('PKEY_Message_FromName',tkVariant,__GetPKEY_Message_FromName,nil,nil,false,0);
    DefineProp('PKEY_Message_HasAttachments',tkVariant,__GetPKEY_Message_HasAttachments,nil,nil,false,0);
    DefineProp('PKEY_Message_IsFwdOrReply',tkVariant,__GetPKEY_Message_IsFwdOrReply,nil,nil,false,0);
    DefineProp('PKEY_Message_MessageClass',tkVariant,__GetPKEY_Message_MessageClass,nil,nil,false,0);
    DefineProp('PKEY_Message_ProofInProgress',tkVariant,__GetPKEY_Message_ProofInProgress,nil,nil,false,0);
    DefineProp('PKEY_Message_SenderAddress',tkVariant,__GetPKEY_Message_SenderAddress,nil,nil,false,0);
    DefineProp('PKEY_Message_SenderName',tkVariant,__GetPKEY_Message_SenderName,nil,nil,false,0);
    DefineProp('PKEY_Message_Store',tkVariant,__GetPKEY_Message_Store,nil,nil,false,0);
    DefineProp('PKEY_Message_ToAddress',tkVariant,__GetPKEY_Message_ToAddress,nil,nil,false,0);
    DefineProp('PKEY_Message_ToDoFlags',tkVariant,__GetPKEY_Message_ToDoFlags,nil,nil,false,0);
    DefineProp('PKEY_Message_ToDoTitle',tkVariant,__GetPKEY_Message_ToDoTitle,nil,nil,false,0);
    DefineProp('PKEY_Message_ToName',tkVariant,__GetPKEY_Message_ToName,nil,nil,false,0);
    DefineProp('PKEY_Music_AlbumArtist',tkVariant,__GetPKEY_Music_AlbumArtist,nil,nil,false,0);
    DefineProp('PKEY_Music_AlbumID',tkVariant,__GetPKEY_Music_AlbumID,nil,nil,false,0);
    DefineProp('PKEY_Music_AlbumTitle',tkVariant,__GetPKEY_Music_AlbumTitle,nil,nil,false,0);
    DefineProp('PKEY_Music_Artist',tkVariant,__GetPKEY_Music_Artist,nil,nil,false,0);
    DefineProp('PKEY_Music_BeatsPerMinute',tkVariant,__GetPKEY_Music_BeatsPerMinute,nil,nil,false,0);
    DefineProp('PKEY_Music_Composer',tkVariant,__GetPKEY_Music_Composer,nil,nil,false,0);
    DefineProp('PKEY_Music_Conductor',tkVariant,__GetPKEY_Music_Conductor,nil,nil,false,0);
    DefineProp('PKEY_Music_ContentGroupDescription',tkVariant,__GetPKEY_Music_ContentGroupDescription,nil,nil,false,0);
    DefineProp('PKEY_Music_Genre',tkVariant,__GetPKEY_Music_Genre,nil,nil,false,0);
    DefineProp('PKEY_Music_InitialKey',tkVariant,__GetPKEY_Music_InitialKey,nil,nil,false,0);
    DefineProp('PKEY_Music_Lyrics',tkVariant,__GetPKEY_Music_Lyrics,nil,nil,false,0);
    DefineProp('PKEY_Music_Mood',tkVariant,__GetPKEY_Music_Mood,nil,nil,false,0);
    DefineProp('PKEY_Music_PartOfSet',tkVariant,__GetPKEY_Music_PartOfSet,nil,nil,false,0);
    DefineProp('PKEY_Music_Period',tkVariant,__GetPKEY_Music_Period,nil,nil,false,0);
    DefineProp('PKEY_Music_SynchronizedLyrics',tkVariant,__GetPKEY_Music_SynchronizedLyrics,nil,nil,false,0);
    DefineProp('PKEY_Music_TrackNumber',tkVariant,__GetPKEY_Music_TrackNumber,nil,nil,false,0);
    DefineProp('PKEY_Note_Color',tkVariant,__GetPKEY_Note_Color,nil,nil,false,0);
    DefineProp('PKEY_Note_ColorText',tkVariant,__GetPKEY_Note_ColorText,nil,nil,false,0);
    DefineProp('PKEY_Photo_Aperture',tkVariant,__GetPKEY_Photo_Aperture,nil,nil,false,0);
    DefineProp('PKEY_Photo_ApertureDenominator',tkVariant,__GetPKEY_Photo_ApertureDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_ApertureNumerator',tkVariant,__GetPKEY_Photo_ApertureNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_Brightness',tkVariant,__GetPKEY_Photo_Brightness,nil,nil,false,0);
    DefineProp('PKEY_Photo_BrightnessDenominator',tkVariant,__GetPKEY_Photo_BrightnessDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_BrightnessNumerator',tkVariant,__GetPKEY_Photo_BrightnessNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_CameraManufacturer',tkVariant,__GetPKEY_Photo_CameraManufacturer,nil,nil,false,0);
    DefineProp('PKEY_Photo_CameraModel',tkVariant,__GetPKEY_Photo_CameraModel,nil,nil,false,0);
    DefineProp('PKEY_Photo_CameraSerialNumber',tkVariant,__GetPKEY_Photo_CameraSerialNumber,nil,nil,false,0);
    DefineProp('PKEY_Photo_Contrast',tkVariant,__GetPKEY_Photo_Contrast,nil,nil,false,0);
    DefineProp('PKEY_Photo_ContrastText',tkVariant,__GetPKEY_Photo_ContrastText,nil,nil,false,0);
    DefineProp('PKEY_Photo_DateTaken',tkVariant,__GetPKEY_Photo_DateTaken,nil,nil,false,0);
    DefineProp('PKEY_Photo_DigitalZoom',tkVariant,__GetPKEY_Photo_DigitalZoom,nil,nil,false,0);
    DefineProp('PKEY_Photo_DigitalZoomDenominator',tkVariant,__GetPKEY_Photo_DigitalZoomDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_DigitalZoomNumerator',tkVariant,__GetPKEY_Photo_DigitalZoomNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_Event',tkVariant,__GetPKEY_Photo_Event,nil,nil,false,0);
    DefineProp('PKEY_Photo_EXIFVersion',tkVariant,__GetPKEY_Photo_EXIFVersion,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureBias',tkVariant,__GetPKEY_Photo_ExposureBias,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureBiasDenominator',tkVariant,__GetPKEY_Photo_ExposureBiasDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureBiasNumerator',tkVariant,__GetPKEY_Photo_ExposureBiasNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureIndex',tkVariant,__GetPKEY_Photo_ExposureIndex,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureIndexDenominator',tkVariant,__GetPKEY_Photo_ExposureIndexDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureIndexNumerator',tkVariant,__GetPKEY_Photo_ExposureIndexNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureProgram',tkVariant,__GetPKEY_Photo_ExposureProgram,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureProgramText',tkVariant,__GetPKEY_Photo_ExposureProgramText,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureTime',tkVariant,__GetPKEY_Photo_ExposureTime,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureTimeDenominator',tkVariant,__GetPKEY_Photo_ExposureTimeDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_ExposureTimeNumerator',tkVariant,__GetPKEY_Photo_ExposureTimeNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_Flash',tkVariant,__GetPKEY_Photo_Flash,nil,nil,false,0);
    DefineProp('PKEY_Photo_FlashEnergy',tkVariant,__GetPKEY_Photo_FlashEnergy,nil,nil,false,0);
    DefineProp('PKEY_Photo_FlashEnergyDenominator',tkVariant,__GetPKEY_Photo_FlashEnergyDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FlashEnergyNumerator',tkVariant,__GetPKEY_Photo_FlashEnergyNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FlashManufacturer',tkVariant,__GetPKEY_Photo_FlashManufacturer,nil,nil,false,0);
    DefineProp('PKEY_Photo_FlashModel',tkVariant,__GetPKEY_Photo_FlashModel,nil,nil,false,0);
    DefineProp('PKEY_Photo_FlashText',tkVariant,__GetPKEY_Photo_FlashText,nil,nil,false,0);
    DefineProp('PKEY_Photo_FNumber',tkVariant,__GetPKEY_Photo_FNumber,nil,nil,false,0);
    DefineProp('PKEY_Photo_FNumberDenominator',tkVariant,__GetPKEY_Photo_FNumberDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FNumberNumerator',tkVariant,__GetPKEY_Photo_FNumberNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalLength',tkVariant,__GetPKEY_Photo_FocalLength,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalLengthDenominator',tkVariant,__GetPKEY_Photo_FocalLengthDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalLengthInFilm',tkVariant,__GetPKEY_Photo_FocalLengthInFilm,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalLengthNumerator',tkVariant,__GetPKEY_Photo_FocalLengthNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalPlaneXResolution',tkVariant,__GetPKEY_Photo_FocalPlaneXResolution,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalPlaneXResolutionDenominator',tkVariant,__GetPKEY_Photo_FocalPlaneXResolutionDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalPlaneXResolutionNumerator',tkVariant,__GetPKEY_Photo_FocalPlaneXResolutionNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalPlaneYResolution',tkVariant,__GetPKEY_Photo_FocalPlaneYResolution,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalPlaneYResolutionDenominator',tkVariant,__GetPKEY_Photo_FocalPlaneYResolutionDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_FocalPlaneYResolutionNumerator',tkVariant,__GetPKEY_Photo_FocalPlaneYResolutionNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_GainControl',tkVariant,__GetPKEY_Photo_GainControl,nil,nil,false,0);
    DefineProp('PKEY_Photo_GainControlDenominator',tkVariant,__GetPKEY_Photo_GainControlDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_GainControlNumerator',tkVariant,__GetPKEY_Photo_GainControlNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_GainControlText',tkVariant,__GetPKEY_Photo_GainControlText,nil,nil,false,0);
    DefineProp('PKEY_Photo_ISOSpeed',tkVariant,__GetPKEY_Photo_ISOSpeed,nil,nil,false,0);
    DefineProp('PKEY_Photo_LensManufacturer',tkVariant,__GetPKEY_Photo_LensManufacturer,nil,nil,false,0);
    DefineProp('PKEY_Photo_LensModel',tkVariant,__GetPKEY_Photo_LensModel,nil,nil,false,0);
    DefineProp('PKEY_Photo_LightSource',tkVariant,__GetPKEY_Photo_LightSource,nil,nil,false,0);
    DefineProp('PKEY_Photo_MakerNote',tkVariant,__GetPKEY_Photo_MakerNote,nil,nil,false,0);
    DefineProp('PKEY_Photo_MakerNoteOffset',tkVariant,__GetPKEY_Photo_MakerNoteOffset,nil,nil,false,0);
    DefineProp('PKEY_Photo_MaxAperture',tkVariant,__GetPKEY_Photo_MaxAperture,nil,nil,false,0);
    DefineProp('PKEY_Photo_MaxApertureDenominator',tkVariant,__GetPKEY_Photo_MaxApertureDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_MaxApertureNumerator',tkVariant,__GetPKEY_Photo_MaxApertureNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_MeteringMode',tkVariant,__GetPKEY_Photo_MeteringMode,nil,nil,false,0);
    DefineProp('PKEY_Photo_MeteringModeText',tkVariant,__GetPKEY_Photo_MeteringModeText,nil,nil,false,0);
    DefineProp('PKEY_Photo_Orientation',tkVariant,__GetPKEY_Photo_Orientation,nil,nil,false,0);
    DefineProp('PKEY_Photo_OrientationText',tkVariant,__GetPKEY_Photo_OrientationText,nil,nil,false,0);
    DefineProp('PKEY_Photo_PeopleNames',tkVariant,__GetPKEY_Photo_PeopleNames,nil,nil,false,0);
    DefineProp('PKEY_Photo_PhotometricInterpretation',tkVariant,__GetPKEY_Photo_PhotometricInterpretation,nil,nil,false,0);
    DefineProp('PKEY_Photo_PhotometricInterpretationText',tkVariant,__GetPKEY_Photo_PhotometricInterpretationText,nil,nil,false,0);
    DefineProp('PKEY_Photo_ProgramMode',tkVariant,__GetPKEY_Photo_ProgramMode,nil,nil,false,0);
    DefineProp('PKEY_Photo_ProgramModeText',tkVariant,__GetPKEY_Photo_ProgramModeText,nil,nil,false,0);
    DefineProp('PKEY_Photo_RelatedSoundFile',tkVariant,__GetPKEY_Photo_RelatedSoundFile,nil,nil,false,0);
    DefineProp('PKEY_Photo_Saturation',tkVariant,__GetPKEY_Photo_Saturation,nil,nil,false,0);
    DefineProp('PKEY_Photo_SaturationText',tkVariant,__GetPKEY_Photo_SaturationText,nil,nil,false,0);
    DefineProp('PKEY_Photo_Sharpness',tkVariant,__GetPKEY_Photo_Sharpness,nil,nil,false,0);
    DefineProp('PKEY_Photo_SharpnessText',tkVariant,__GetPKEY_Photo_SharpnessText,nil,nil,false,0);
    DefineProp('PKEY_Photo_ShutterSpeed',tkVariant,__GetPKEY_Photo_ShutterSpeed,nil,nil,false,0);
    DefineProp('PKEY_Photo_ShutterSpeedDenominator',tkVariant,__GetPKEY_Photo_ShutterSpeedDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_ShutterSpeedNumerator',tkVariant,__GetPKEY_Photo_ShutterSpeedNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_SubjectDistance',tkVariant,__GetPKEY_Photo_SubjectDistance,nil,nil,false,0);
    DefineProp('PKEY_Photo_SubjectDistanceDenominator',tkVariant,__GetPKEY_Photo_SubjectDistanceDenominator,nil,nil,false,0);
    DefineProp('PKEY_Photo_SubjectDistanceNumerator',tkVariant,__GetPKEY_Photo_SubjectDistanceNumerator,nil,nil,false,0);
    DefineProp('PKEY_Photo_TagViewAggregate',tkVariant,__GetPKEY_Photo_TagViewAggregate,nil,nil,false,0);
    DefineProp('PKEY_Photo_TranscodedForSync',tkVariant,__GetPKEY_Photo_TranscodedForSync,nil,nil,false,0);
    DefineProp('PKEY_Photo_WhiteBalance',tkVariant,__GetPKEY_Photo_WhiteBalance,nil,nil,false,0);
    DefineProp('PKEY_Photo_WhiteBalanceText',tkVariant,__GetPKEY_Photo_WhiteBalanceText,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Advanced',tkVariant,__GetPKEY_PropGroup_Advanced,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Audio',tkVariant,__GetPKEY_PropGroup_Audio,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Calendar',tkVariant,__GetPKEY_PropGroup_Calendar,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Camera',tkVariant,__GetPKEY_PropGroup_Camera,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Contact',tkVariant,__GetPKEY_PropGroup_Contact,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Content',tkVariant,__GetPKEY_PropGroup_Content,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Description',tkVariant,__GetPKEY_PropGroup_Description,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_FileSystem',tkVariant,__GetPKEY_PropGroup_FileSystem,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_General',tkVariant,__GetPKEY_PropGroup_General,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_GPS',tkVariant,__GetPKEY_PropGroup_GPS,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Image',tkVariant,__GetPKEY_PropGroup_Image,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Media',tkVariant,__GetPKEY_PropGroup_Media,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_MediaAdvanced',tkVariant,__GetPKEY_PropGroup_MediaAdvanced,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Message',tkVariant,__GetPKEY_PropGroup_Message,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Music',tkVariant,__GetPKEY_PropGroup_Music,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Origin',tkVariant,__GetPKEY_PropGroup_Origin,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_PhotoAdvanced',tkVariant,__GetPKEY_PropGroup_PhotoAdvanced,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_RecordedTV',tkVariant,__GetPKEY_PropGroup_RecordedTV,nil,nil,false,0);
    DefineProp('PKEY_PropGroup_Video',tkVariant,__GetPKEY_PropGroup_Video,nil,nil,false,0);
    DefineProp('PKEY_InfoTipText',tkVariant,__GetPKEY_InfoTipText,nil,nil,false,0);
    DefineProp('PKEY_PropList_ConflictPrompt',tkVariant,__GetPKEY_PropList_ConflictPrompt,nil,nil,false,0);
    DefineProp('PKEY_PropList_ContentViewModeForBrowse',tkVariant,__GetPKEY_PropList_ContentViewModeForBrowse,nil,nil,false,0);
    DefineProp('PKEY_PropList_ContentViewModeForSearch',tkVariant,__GetPKEY_PropList_ContentViewModeForSearch,nil,nil,false,0);
    DefineProp('PKEY_PropList_ExtendedTileInfo',tkVariant,__GetPKEY_PropList_ExtendedTileInfo,nil,nil,false,0);
    DefineProp('PKEY_PropList_FileOperationPrompt',tkVariant,__GetPKEY_PropList_FileOperationPrompt,nil,nil,false,0);
    DefineProp('PKEY_PropList_FullDetails',tkVariant,__GetPKEY_PropList_FullDetails,nil,nil,false,0);
    DefineProp('PKEY_PropList_InfoTip',tkVariant,__GetPKEY_PropList_InfoTip,nil,nil,false,0);
    DefineProp('PKEY_PropList_NonPersonal',tkVariant,__GetPKEY_PropList_NonPersonal,nil,nil,false,0);
    DefineProp('PKEY_PropList_PreviewDetails',tkVariant,__GetPKEY_PropList_PreviewDetails,nil,nil,false,0);
    DefineProp('PKEY_PropList_PreviewTitle',tkVariant,__GetPKEY_PropList_PreviewTitle,nil,nil,false,0);
    DefineProp('PKEY_PropList_QuickTip',tkVariant,__GetPKEY_PropList_QuickTip,nil,nil,false,0);
    DefineProp('PKEY_PropList_TileInfo',tkVariant,__GetPKEY_PropList_TileInfo,nil,nil,false,0);
    DefineProp('PKEY_PropList_XPDetailsPanel',tkVariant,__GetPKEY_PropList_XPDetailsPanel,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_ChannelNumber',tkVariant,__GetPKEY_RecordedTV_ChannelNumber,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_Credits',tkVariant,__GetPKEY_RecordedTV_Credits,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_DateContentExpires',tkVariant,__GetPKEY_RecordedTV_DateContentExpires,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_EpisodeName',tkVariant,__GetPKEY_RecordedTV_EpisodeName,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_IsATSCContent',tkVariant,__GetPKEY_RecordedTV_IsATSCContent,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_IsClosedCaptioningAvailable',tkVariant,__GetPKEY_RecordedTV_IsClosedCaptioningAvailable,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_IsDTVContent',tkVariant,__GetPKEY_RecordedTV_IsDTVContent,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_IsHDContent',tkVariant,__GetPKEY_RecordedTV_IsHDContent,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_IsRepeatBroadcast',tkVariant,__GetPKEY_RecordedTV_IsRepeatBroadcast,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_IsSAP',tkVariant,__GetPKEY_RecordedTV_IsSAP,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_NetworkAffiliation',tkVariant,__GetPKEY_RecordedTV_NetworkAffiliation,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_OriginalBroadcastDate',tkVariant,__GetPKEY_RecordedTV_OriginalBroadcastDate,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_ProgramDescription',tkVariant,__GetPKEY_RecordedTV_ProgramDescription,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_RecordingTime',tkVariant,__GetPKEY_RecordedTV_RecordingTime,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_StationCallSign',tkVariant,__GetPKEY_RecordedTV_StationCallSign,nil,nil,false,0);
    DefineProp('PKEY_RecordedTV_StationName',tkVariant,__GetPKEY_RecordedTV_StationName,nil,nil,false,0);
    DefineProp('PKEY_Search_AutoSummary',tkVariant,__GetPKEY_Search_AutoSummary,nil,nil,false,0);
    DefineProp('PKEY_Search_ContainerHash',tkVariant,__GetPKEY_Search_ContainerHash,nil,nil,false,0);
    DefineProp('PKEY_Search_Contents',tkVariant,__GetPKEY_Search_Contents,nil,nil,false,0);
    DefineProp('PKEY_Search_EntryID',tkVariant,__GetPKEY_Search_EntryID,nil,nil,false,0);
    DefineProp('PKEY_Search_ExtendedProperties',tkVariant,__GetPKEY_Search_ExtendedProperties,nil,nil,false,0);
    DefineProp('PKEY_Search_GatherTime',tkVariant,__GetPKEY_Search_GatherTime,nil,nil,false,0);
    DefineProp('PKEY_Search_HitCount',tkVariant,__GetPKEY_Search_HitCount,nil,nil,false,0);
    DefineProp('PKEY_Search_IsClosedDirectory',tkVariant,__GetPKEY_Search_IsClosedDirectory,nil,nil,false,0);
    DefineProp('PKEY_Search_IsFullyContained',tkVariant,__GetPKEY_Search_IsFullyContained,nil,nil,false,0);
    DefineProp('PKEY_Search_QueryFocusedSummary',tkVariant,__GetPKEY_Search_QueryFocusedSummary,nil,nil,false,0);
    DefineProp('PKEY_Search_QueryFocusedSummaryWithFallback',tkVariant,__GetPKEY_Search_QueryFocusedSummaryWithFallback,nil,nil,false,0);
    DefineProp('PKEY_Search_Rank',tkVariant,__GetPKEY_Search_Rank,nil,nil,false,0);
    DefineProp('PKEY_Search_Store',tkVariant,__GetPKEY_Search_Store,nil,nil,false,0);
    DefineProp('PKEY_Search_UrlToIndex',tkVariant,__GetPKEY_Search_UrlToIndex,nil,nil,false,0);
    DefineProp('PKEY_Search_UrlToIndexWithModificationTime',tkVariant,__GetPKEY_Search_UrlToIndexWithModificationTime,nil,nil,false,0);
    DefineProp('PKEY_DescriptionID',tkVariant,__GetPKEY_DescriptionID,nil,nil,false,0);
    DefineProp('PKEY_InternalName',tkVariant,__GetPKEY_InternalName,nil,nil,false,0);
    DefineProp('PKEY_Link_TargetSFGAOFlagsStrings',tkVariant,__GetPKEY_Link_TargetSFGAOFlagsStrings,nil,nil,false,0);
    DefineProp('PKEY_Link_TargetUrl',tkVariant,__GetPKEY_Link_TargetUrl,nil,nil,false,0);
    DefineProp('PKEY_NamespaceCLSID',tkVariant,__GetPKEY_NamespaceCLSID,nil,nil,false,0);
    DefineProp('PKEY_Shell_SFGAOFlagsStrings',tkVariant,__GetPKEY_Shell_SFGAOFlagsStrings,nil,nil,false,0);
    DefineProp('PKEY_AppUserModel_ExcludeFromShowInNewInstall',tkVariant,__GetPKEY_AppUserModel_ExcludeFromShowInNewInstall,nil,nil,false,0);
    DefineProp('PKEY_AppUserModel_ID',tkVariant,__GetPKEY_AppUserModel_ID,nil,nil,false,0);
    DefineProp('PKEY_AppUserModel_IsDestListSeparator',tkVariant,__GetPKEY_AppUserModel_IsDestListSeparator,nil,nil,false,0);
    DefineProp('PKEY_AppUserModel_RelaunchCommand',tkVariant,__GetPKEY_AppUserModel_RelaunchCommand,nil,nil,false,0);
    DefineProp('PKEY_AppUserModel_RelaunchDisplayNameResource',tkVariant,__GetPKEY_AppUserModel_RelaunchDisplayNameResource,nil,nil,false,0);
    DefineProp('PKEY_AppUserModel_RelaunchIconResource',tkVariant,__GetPKEY_AppUserModel_RelaunchIconResource,nil,nil,false,0);
    DefineProp('PKEY_Software_DateLastUsed',tkVariant,__GetPKEY_Software_DateLastUsed,nil,nil,false,0);
    DefineProp('PKEY_Software_ProductName',tkVariant,__GetPKEY_Software_ProductName,nil,nil,false,0);
    DefineProp('PKEY_Sync_Comments',tkVariant,__GetPKEY_Sync_Comments,nil,nil,false,0);
    DefineProp('PKEY_Sync_ConflictDescription',tkVariant,__GetPKEY_Sync_ConflictDescription,nil,nil,false,0);
    DefineProp('PKEY_Sync_ConflictFirstLocation',tkVariant,__GetPKEY_Sync_ConflictFirstLocation,nil,nil,false,0);
    DefineProp('PKEY_Sync_ConflictSecondLocation',tkVariant,__GetPKEY_Sync_ConflictSecondLocation,nil,nil,false,0);
    DefineProp('PKEY_Sync_HandlerCollectionID',tkVariant,__GetPKEY_Sync_HandlerCollectionID,nil,nil,false,0);
    DefineProp('PKEY_Sync_HandlerID',tkVariant,__GetPKEY_Sync_HandlerID,nil,nil,false,0);
    DefineProp('PKEY_Sync_HandlerName',tkVariant,__GetPKEY_Sync_HandlerName,nil,nil,false,0);
    DefineProp('PKEY_Sync_HandlerType',tkVariant,__GetPKEY_Sync_HandlerType,nil,nil,false,0);
    DefineProp('PKEY_Sync_HandlerTypeLabel',tkVariant,__GetPKEY_Sync_HandlerTypeLabel,nil,nil,false,0);
    DefineProp('PKEY_Sync_ItemID',tkVariant,__GetPKEY_Sync_ItemID,nil,nil,false,0);
    DefineProp('PKEY_Sync_ItemName',tkVariant,__GetPKEY_Sync_ItemName,nil,nil,false,0);
    DefineProp('PKEY_Sync_ProgressPercentage',tkVariant,__GetPKEY_Sync_ProgressPercentage,nil,nil,false,0);
    DefineProp('PKEY_Sync_State',tkVariant,__GetPKEY_Sync_State,nil,nil,false,0);
    DefineProp('PKEY_Sync_Status',tkVariant,__GetPKEY_Sync_Status,nil,nil,false,0);
    DefineProp('PKEY_Task_BillingInformation',tkVariant,__GetPKEY_Task_BillingInformation,nil,nil,false,0);
    DefineProp('PKEY_Task_CompletionStatus',tkVariant,__GetPKEY_Task_CompletionStatus,nil,nil,false,0);
    DefineProp('PKEY_Task_Owner',tkVariant,__GetPKEY_Task_Owner,nil,nil,false,0);
    DefineProp('PKEY_Video_Compression',tkVariant,__GetPKEY_Video_Compression,nil,nil,false,0);
    DefineProp('PKEY_Video_Director',tkVariant,__GetPKEY_Video_Director,nil,nil,false,0);
    DefineProp('PKEY_Video_EncodingBitrate',tkVariant,__GetPKEY_Video_EncodingBitrate,nil,nil,false,0);
    DefineProp('PKEY_Video_FourCC',tkVariant,__GetPKEY_Video_FourCC,nil,nil,false,0);
    DefineProp('PKEY_Video_FrameHeight',tkVariant,__GetPKEY_Video_FrameHeight,nil,nil,false,0);
    DefineProp('PKEY_Video_FrameRate',tkVariant,__GetPKEY_Video_FrameRate,nil,nil,false,0);
    DefineProp('PKEY_Video_FrameWidth',tkVariant,__GetPKEY_Video_FrameWidth,nil,nil,false,0);
    DefineProp('PKEY_Video_HorizontalAspectRatio',tkVariant,__GetPKEY_Video_HorizontalAspectRatio,nil,nil,false,0);
    DefineProp('PKEY_Video_SampleSize',tkVariant,__GetPKEY_Video_SampleSize,nil,nil,false,0);
    DefineProp('PKEY_Video_StreamName',tkVariant,__GetPKEY_Video_StreamName,nil,nil,false,0);
    DefineProp('PKEY_Video_StreamNumber',tkVariant,__GetPKEY_Video_StreamNumber,nil,nil,false,0);
    DefineProp('PKEY_Video_TotalBitrate',tkVariant,__GetPKEY_Video_TotalBitrate,nil,nil,false,0);
    DefineProp('PKEY_Video_VerticalAspectRatio',tkVariant,__GetPKEY_Video_VerticalAspectRatio,nil,nil,false,0);
    DefineProp('PKEY_Volume_FileSystem',tkVariant,__GetPKEY_Volume_FileSystem,nil,nil,false,0);
    DefineProp('PKEY_Volume_IsMappedDrive',tkVariant,__GetPKEY_Volume_IsMappedDrive,nil,nil,false,0);
    DefineProp('PKEY_Volume_IsRoot',tkVariant,__GetPKEY_Volume_IsRoot,nil,nil,false,0);
    AddConstant('AUDIO_CHANNELCOUNT_MONO',AUDIO_CHANNELCOUNT_MONO);
    AddConstant('AUDIO_CHANNELCOUNT_STEREO',AUDIO_CHANNELCOUNT_STEREO);
    AddConstant('CALENDAR_RESPONSESTATUS_NONE',CALENDAR_RESPONSESTATUS_NONE);
    AddConstant('CALENDAR_RESPONSESTATUS_ORGANIZED',CALENDAR_RESPONSESTATUS_ORGANIZED);
    AddConstant('CALENDAR_RESPONSESTATUS_TENTATIVE',CALENDAR_RESPONSESTATUS_TENTATIVE);
    AddConstant('CALENDAR_RESPONSESTATUS_ACCEPTED',CALENDAR_RESPONSESTATUS_ACCEPTED);
    AddConstant('CALENDAR_RESPONSESTATUS_DECLINED',CALENDAR_RESPONSESTATUS_DECLINED);
    AddConstant('CALENDAR_RESPONSESTATUS_NOTRESPONDED',CALENDAR_RESPONSESTATUS_NOTRESPONDED);
    AddConstant('CALENDAR_SHOWTIMEAS_FREE',CALENDAR_SHOWTIMEAS_FREE);
    AddConstant('CALENDAR_SHOWTIMEAS_TENTATIVE',CALENDAR_SHOWTIMEAS_TENTATIVE);
    AddConstant('CALENDAR_SHOWTIMEAS_BUSY',CALENDAR_SHOWTIMEAS_BUSY);
    AddConstant('CALENDAR_SHOWTIMEAS_OOF',CALENDAR_SHOWTIMEAS_OOF);
    AddConstant('TASKSTATUS_NOTSTARTED',TASKSTATUS_NOTSTARTED);
    AddConstant('TASKSTATUS_INPROGRESS',TASKSTATUS_INPROGRESS);
    AddConstant('TASKSTATUS_COMPLETE',TASKSTATUS_COMPLETE);
    AddConstant('TASKSTATUS_WAITING',TASKSTATUS_WAITING);
    AddConstant('TASKSTATUS_DEFERRED',TASKSTATUS_DEFERRED);
    AddConstant('GENDERVALUE_UNSPECIFIED',GENDERVALUE_UNSPECIFIED);
    AddConstant('GENDERVALUE_FEMALE',GENDERVALUE_FEMALE);
    AddConstant('GENDERVALUE_MALE',GENDERVALUE_MALE);
    AddConstant('FLAGCOLOR_PURPLE',FLAGCOLOR_PURPLE);
    AddConstant('FLAGCOLOR_ORANGE',FLAGCOLOR_ORANGE);
    AddConstant('FLAGCOLOR_GREEN',FLAGCOLOR_GREEN);
    AddConstant('FLAGCOLOR_YELLOW',FLAGCOLOR_YELLOW);
    AddConstant('FLAGCOLOR_BLUE',FLAGCOLOR_BLUE);
    AddConstant('FLAGCOLOR_RED',FLAGCOLOR_RED);
    AddConstant('FLAGSTATUS_NOTFLAGGED',FLAGSTATUS_NOTFLAGGED);
    AddConstant('FLAGSTATUS_COMPLETED',FLAGSTATUS_COMPLETED);
    AddConstant('FLAGSTATUS_FOLLOWUP',FLAGSTATUS_FOLLOWUP);
    AddConstant('IMPORTANCE_LOW_MIN',IMPORTANCE_LOW_MIN);
    AddConstant('IMPORTANCE_LOW_SET',IMPORTANCE_LOW_SET);
    AddConstant('IMPORTANCE_LOW_MAX',IMPORTANCE_LOW_MAX);
    AddConstant('IMPORTANCE_NORMAL_MIN',IMPORTANCE_NORMAL_MIN);
    AddConstant('IMPORTANCE_NORMAL_SET',IMPORTANCE_NORMAL_SET);
    AddConstant('IMPORTANCE_NORMAL_MAX',IMPORTANCE_NORMAL_MAX);
    AddConstant('IMPORTANCE_HIGH_MIN',IMPORTANCE_HIGH_MIN);
    AddConstant('IMPORTANCE_HIGH_SET',IMPORTANCE_HIGH_SET);
    AddConstant('IMPORTANCE_HIGH_MAX',IMPORTANCE_HIGH_MAX);
    AddConstant('KIND_CALENDAR',KIND_CALENDAR);
    AddConstant('KIND_COMMUNICATION',KIND_COMMUNICATION);
    AddConstant('KIND_CONTACT',KIND_CONTACT);
    AddConstant('KIND_DOCUMENT',KIND_DOCUMENT);
    AddConstant('KIND_EMAIL',KIND_EMAIL);
    AddConstant('KIND_FEED',KIND_FEED);
    AddConstant('KIND_FOLDER',KIND_FOLDER);
    AddConstant('KIND_GAME',KIND_GAME);
    AddConstant('KIND_INSTANTMESSAGE',KIND_INSTANTMESSAGE);
    AddConstant('KIND_JOURNAL',KIND_JOURNAL);
    AddConstant('KIND_LINK',KIND_LINK);
    AddConstant('KIND_MOVIE',KIND_MOVIE);
    AddConstant('KIND_MUSIC',KIND_MUSIC);
    AddConstant('KIND_NOTE',KIND_NOTE);
    AddConstant('KIND_PICTURE',KIND_PICTURE);
    AddConstant('KIND_PROGRAM',KIND_PROGRAM);
    AddConstant('KIND_RECORDEDTV',KIND_RECORDEDTV);
    AddConstant('KIND_SEARCHFOLDER',KIND_SEARCHFOLDER);
    AddConstant('KIND_TASK',KIND_TASK);
    AddConstant('KIND_VIDEO',KIND_VIDEO);
    AddConstant('KIND_WEBHISTORY',KIND_WEBHISTORY);
    AddConstant('OFFLINEAVAILABILITY_NOT_AVAILABLE',OFFLINEAVAILABILITY_NOT_AVAILABLE);
    AddConstant('OFFLINEAVAILABILITY_AVAILABLE',OFFLINEAVAILABILITY_AVAILABLE);
    AddConstant('OFFLINEAVAILABILITY_ALWAYS_AVAILABLE',OFFLINEAVAILABILITY_ALWAYS_AVAILABLE);
    AddConstant('OFFLINESTATUS_ONLINE',OFFLINESTATUS_ONLINE);
    AddConstant('OFFLINESTATUS_OFFLINE',OFFLINESTATUS_OFFLINE);
    AddConstant('OFFLINESTATUS_OFFLINE_FORCED',OFFLINESTATUS_OFFLINE_FORCED);
    AddConstant('OFFLINESTATUS_OFFLINE_SLOW',OFFLINESTATUS_OFFLINE_SLOW);
    AddConstant('OFFLINESTATUS_OFFLINE_ERROR',OFFLINESTATUS_OFFLINE_ERROR);
    AddConstant('OFFLINESTATUS_OFFLINE_ITEM_VERSION_CONFLICT',OFFLINESTATUS_OFFLINE_ITEM_VERSION_CONFLICT);
    AddConstant('OFFLINESTATUS_OFFLINE_SUSPENDED',OFFLINESTATUS_OFFLINE_SUSPENDED);
    AddConstant('PRIORITY_PROP_LOW',PRIORITY_PROP_LOW);
    AddConstant('PRIORITY_PROP_NORMAL',PRIORITY_PROP_NORMAL);
    AddConstant('PRIORITY_PROP_HIGH',PRIORITY_PROP_HIGH);
    AddConstant('RATING_UNRATED_MIN',RATING_UNRATED_MIN);
    AddConstant('RATING_UNRATED_SET',RATING_UNRATED_SET);
    AddConstant('RATING_UNRATED_MAX',RATING_UNRATED_MAX);
    AddConstant('RATING_ONE_STAR_MIN',RATING_ONE_STAR_MIN);
    AddConstant('RATING_ONE_STAR_SET',RATING_ONE_STAR_SET);
    AddConstant('RATING_ONE_STAR_MAX',RATING_ONE_STAR_MAX);
    AddConstant('RATING_TWO_STARS_MIN',RATING_TWO_STARS_MIN);
    AddConstant('RATING_TWO_STARS_SET',RATING_TWO_STARS_SET);
    AddConstant('RATING_TWO_STARS_MAX',RATING_TWO_STARS_MAX);
    AddConstant('RATING_THREE_STARS_MIN',RATING_THREE_STARS_MIN);
    AddConstant('RATING_THREE_STARS_SET',RATING_THREE_STARS_SET);
    AddConstant('RATING_THREE_STARS_MAX',RATING_THREE_STARS_MAX);
    AddConstant('RATING_FOUR_STARS_MIN',RATING_FOUR_STARS_MIN);
    AddConstant('RATING_FOUR_STARS_SET',RATING_FOUR_STARS_SET);
    AddConstant('RATING_FOUR_STARS_MAX',RATING_FOUR_STARS_MAX);
    AddConstant('RATING_FIVE_STARS_MIN',RATING_FIVE_STARS_MIN);
    AddConstant('RATING_FIVE_STARS_SET',RATING_FIVE_STARS_SET);
    AddConstant('RATING_FIVE_STARS_MAX',RATING_FIVE_STARS_MAX);
    AddConstant('SENSITIVITY_PROP_NORMAL',SENSITIVITY_PROP_NORMAL);
    AddConstant('SENSITIVITY_PROP_PERSONAL',SENSITIVITY_PROP_PERSONAL);
    AddConstant('SENSITIVITY_PROP_PRIVATE',SENSITIVITY_PROP_PRIVATE);
    AddConstant('SENSITIVITY_PROP_CONFIDENTIAL',SENSITIVITY_PROP_CONFIDENTIAL);
    AddConstant('SHARINGSTATUS_NOTSHARED',SHARINGSTATUS_NOTSHARED);
    AddConstant('SHARINGSTATUS_SHARED',SHARINGSTATUS_SHARED);
    AddConstant('SHARINGSTATUS_PRIVATE',SHARINGSTATUS_PRIVATE);
    AddConstant('SHARINGSTATUS_EVERYONE',SHARINGSTATUS_EVERYONE);
    AddConstant('IMAGE_COLORSPACE_SRGB',IMAGE_COLORSPACE_SRGB);
    AddConstant('IMAGE_COLORSPACE_UNCALIBRATED',IMAGE_COLORSPACE_UNCALIBRATED);
    AddConstant('IMAGE_COMPRESSION_UNCOMPRESSED',IMAGE_COMPRESSION_UNCOMPRESSED);
    AddConstant('IMAGE_COMPRESSION_CCITT_T3',IMAGE_COMPRESSION_CCITT_T3);
    AddConstant('IMAGE_COMPRESSION_CCITT_T4',IMAGE_COMPRESSION_CCITT_T4);
    AddConstant('IMAGE_COMPRESSION_CCITT_T6',IMAGE_COMPRESSION_CCITT_T6);
    AddConstant('IMAGE_COMPRESSION_LZW',IMAGE_COMPRESSION_LZW);
    AddConstant('IMAGE_COMPRESSION_JPEG',IMAGE_COMPRESSION_JPEG);
    AddConstant('IMAGE_COMPRESSION_PACKBITS',IMAGE_COMPRESSION_PACKBITS);
    AddConstant('LAYOUTPATTERN_CVMFB_ALPHA',LAYOUTPATTERN_CVMFB_ALPHA);
    AddConstant('LAYOUTPATTERN_CVMFB_BETA',LAYOUTPATTERN_CVMFB_BETA);
    AddConstant('LAYOUTPATTERN_CVMFB_GAMMA',LAYOUTPATTERN_CVMFB_GAMMA);
    AddConstant('LAYOUTPATTERN_CVMFB_DELTA',LAYOUTPATTERN_CVMFB_DELTA);
    AddConstant('LAYOUTPATTERN_CVMFB_EPSILON',LAYOUTPATTERN_CVMFB_EPSILON);
    AddConstant('LAYOUTPATTERN_CVMFS_ALPHA',LAYOUTPATTERN_CVMFS_ALPHA);
    AddConstant('LAYOUTPATTERN_CVMFS_BETA',LAYOUTPATTERN_CVMFS_BETA);
    AddConstant('LAYOUTPATTERN_CVMFS_GAMMA',LAYOUTPATTERN_CVMFS_GAMMA);
    AddConstant('LAYOUTPATTERN_CVMFS_DELTA',LAYOUTPATTERN_CVMFS_DELTA);
    AddConstant('LAYOUTPATTERN_CVMFS_EPSILON',LAYOUTPATTERN_CVMFS_EPSILON);
    AddConstant('LINK_STATUS_RESOLVED',LINK_STATUS_RESOLVED);
    AddConstant('LINK_STATUS_BROKEN',LINK_STATUS_BROKEN);
    AddConstant('NOTE_COLOR_BLUE',NOTE_COLOR_BLUE);
    AddConstant('NOTE_COLOR_GREEN',NOTE_COLOR_GREEN);
    AddConstant('NOTE_COLOR_PINK',NOTE_COLOR_PINK);
    AddConstant('NOTE_COLOR_YELLOW',NOTE_COLOR_YELLOW);
    AddConstant('NOTE_COLOR_WHITE',NOTE_COLOR_WHITE);
    AddConstant('NOTE_COLOR_LIGHTGREEN',NOTE_COLOR_LIGHTGREEN);
    AddConstant('PHOTO_CONTRAST_NORMAL',PHOTO_CONTRAST_NORMAL);
    AddConstant('PHOTO_CONTRAST_SOFT',PHOTO_CONTRAST_SOFT);
    AddConstant('PHOTO_CONTRAST_HARD',PHOTO_CONTRAST_HARD);
    AddConstant('PHOTO_EXPOSUREPROGRAM_UNKNOWN',PHOTO_EXPOSUREPROGRAM_UNKNOWN);
    AddConstant('PHOTO_EXPOSUREPROGRAM_MANUAL',PHOTO_EXPOSUREPROGRAM_MANUAL);
    AddConstant('PHOTO_EXPOSUREPROGRAM_NORMAL',PHOTO_EXPOSUREPROGRAM_NORMAL);
    AddConstant('PHOTO_EXPOSUREPROGRAM_APERTURE',PHOTO_EXPOSUREPROGRAM_APERTURE);
    AddConstant('PHOTO_EXPOSUREPROGRAM_SHUTTER',PHOTO_EXPOSUREPROGRAM_SHUTTER);
    AddConstant('PHOTO_EXPOSUREPROGRAM_CREATIVE',PHOTO_EXPOSUREPROGRAM_CREATIVE);
    AddConstant('PHOTO_EXPOSUREPROGRAM_ACTION',PHOTO_EXPOSUREPROGRAM_ACTION);
    AddConstant('PHOTO_EXPOSUREPROGRAM_PORTRAIT',PHOTO_EXPOSUREPROGRAM_PORTRAIT);
    AddConstant('PHOTO_EXPOSUREPROGRAM_LANDSCAPE',PHOTO_EXPOSUREPROGRAM_LANDSCAPE);
    AddConstant('PHOTO_FLASH_NONE',PHOTO_FLASH_NONE);
    AddConstant('PHOTO_FLASH_FLASH',PHOTO_FLASH_FLASH);
    AddConstant('PHOTO_FLASH_WITHOUTSTROBE',PHOTO_FLASH_WITHOUTSTROBE);
    AddConstant('PHOTO_FLASH_WITHSTROBE',PHOTO_FLASH_WITHSTROBE);
    AddConstant('PHOTO_FLASH_FLASH_COMPULSORY',PHOTO_FLASH_FLASH_COMPULSORY);
    AddConstant('PHOTO_FLASH_FLASH_COMPULSORY_NORETURNLIGHT',PHOTO_FLASH_FLASH_COMPULSORY_NORETURNLIGHT);
    AddConstant('PHOTO_FLASH_FLASH_COMPULSORY_RETURNLIGHT',PHOTO_FLASH_FLASH_COMPULSORY_RETURNLIGHT);
    AddConstant('PHOTO_FLASH_NONE_COMPULSORY',PHOTO_FLASH_NONE_COMPULSORY);
    AddConstant('PHOTO_FLASH_NONE_AUTO',PHOTO_FLASH_NONE_AUTO);
    AddConstant('PHOTO_FLASH_FLASH_AUTO',PHOTO_FLASH_FLASH_AUTO);
    AddConstant('PHOTO_FLASH_FLASH_AUTO_NORETURNLIGHT',PHOTO_FLASH_FLASH_AUTO_NORETURNLIGHT);
    AddConstant('PHOTO_FLASH_FLASH_AUTO_RETURNLIGHT',PHOTO_FLASH_FLASH_AUTO_RETURNLIGHT);
    AddConstant('PHOTO_FLASH_NOFUNCTION',PHOTO_FLASH_NOFUNCTION);
    AddConstant('PHOTO_FLASH_FLASH_REDEYE',PHOTO_FLASH_FLASH_REDEYE);
    AddConstant('PHOTO_FLASH_FLASH_REDEYE_NORETURNLIGHT',PHOTO_FLASH_FLASH_REDEYE_NORETURNLIGHT);
    AddConstant('PHOTO_FLASH_FLASH_REDEYE_RETURNLIGHT',PHOTO_FLASH_FLASH_REDEYE_RETURNLIGHT);
    AddConstant('PHOTO_FLASH_FLASH_COMPULSORY_REDEYE',PHOTO_FLASH_FLASH_COMPULSORY_REDEYE);
    AddConstant('PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_NORETURNLIGHT',PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_NORETURNLIGHT);
    AddConstant('PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_RETURNLIGHT',PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_RETURNLIGHT);
    AddConstant('PHOTO_FLASH_FLASH_AUTO_REDEYE',PHOTO_FLASH_FLASH_AUTO_REDEYE);
    AddConstant('PHOTO_FLASH_FLASH_AUTO_REDEYE_NORETURNLIGHT',PHOTO_FLASH_FLASH_AUTO_REDEYE_NORETURNLIGHT);
    AddConstant('PHOTO_FLASH_FLASH_AUTO_REDEYE_RETURNLIGHT',PHOTO_FLASH_FLASH_AUTO_REDEYE_RETURNLIGHT);
    AddConstant('PHOTO_GAINCONTROL_NONE',PHOTO_GAINCONTROL_NONE);
    AddConstant('PHOTO_GAINCONTROL_LOWGAINUP',PHOTO_GAINCONTROL_LOWGAINUP);
    AddConstant('PHOTO_GAINCONTROL_HIGHGAINUP',PHOTO_GAINCONTROL_HIGHGAINUP);
    AddConstant('PHOTO_GAINCONTROL_LOWGAINDOWN',PHOTO_GAINCONTROL_LOWGAINDOWN);
    AddConstant('PHOTO_GAINCONTROL_HIGHGAINDOWN',PHOTO_GAINCONTROL_HIGHGAINDOWN);
    AddConstant('PHOTO_LIGHTSOURCE_UNKNOWN',PHOTO_LIGHTSOURCE_UNKNOWN);
    AddConstant('PHOTO_LIGHTSOURCE_DAYLIGHT',PHOTO_LIGHTSOURCE_DAYLIGHT);
    AddConstant('PHOTO_LIGHTSOURCE_FLUORESCENT',PHOTO_LIGHTSOURCE_FLUORESCENT);
    AddConstant('PHOTO_LIGHTSOURCE_TUNGSTEN',PHOTO_LIGHTSOURCE_TUNGSTEN);
    AddConstant('PHOTO_LIGHTSOURCE_STANDARD_A',PHOTO_LIGHTSOURCE_STANDARD_A);
    AddConstant('PHOTO_LIGHTSOURCE_STANDARD_B',PHOTO_LIGHTSOURCE_STANDARD_B);
    AddConstant('PHOTO_LIGHTSOURCE_STANDARD_C',PHOTO_LIGHTSOURCE_STANDARD_C);
    AddConstant('PHOTO_LIGHTSOURCE_D55',PHOTO_LIGHTSOURCE_D55);
    AddConstant('PHOTO_LIGHTSOURCE_D65',PHOTO_LIGHTSOURCE_D65);
    AddConstant('PHOTO_LIGHTSOURCE_D75',PHOTO_LIGHTSOURCE_D75);
    AddConstant('PHOTO_METERINGMODE_UNKNOWN',PHOTO_METERINGMODE_UNKNOWN);
    AddConstant('PHOTO_METERINGMODE_AVERAGE',PHOTO_METERINGMODE_AVERAGE);
    AddConstant('PHOTO_METERINGMODE_CENTER',PHOTO_METERINGMODE_CENTER);
    AddConstant('PHOTO_METERINGMODE_SPOT',PHOTO_METERINGMODE_SPOT);
    AddConstant('PHOTO_METERINGMODE_MULTISPOT',PHOTO_METERINGMODE_MULTISPOT);
    AddConstant('PHOTO_METERINGMODE_PATTERN',PHOTO_METERINGMODE_PATTERN);
    AddConstant('PHOTO_METERINGMODE_PARTIAL',PHOTO_METERINGMODE_PARTIAL);
    AddConstant('PHOTO_ORIENTATION_NORMAL',PHOTO_ORIENTATION_NORMAL);
    AddConstant('PHOTO_ORIENTATION_FLIPHORIZONTAL',PHOTO_ORIENTATION_FLIPHORIZONTAL);
    AddConstant('PHOTO_ORIENTATION_ROTATE180',PHOTO_ORIENTATION_ROTATE180);
    AddConstant('PHOTO_ORIENTATION_FLIPVERTICAL',PHOTO_ORIENTATION_FLIPVERTICAL);
    AddConstant('PHOTO_ORIENTATION_TRANSPOSE',PHOTO_ORIENTATION_TRANSPOSE);
    AddConstant('PHOTO_ORIENTATION_ROTATE270',PHOTO_ORIENTATION_ROTATE270);
    AddConstant('PHOTO_ORIENTATION_TRANSVERSE',PHOTO_ORIENTATION_TRANSVERSE);
    AddConstant('PHOTO_ORIENTATION_ROTATE90',PHOTO_ORIENTATION_ROTATE90);
    AddConstant('PHOTO_PHOTOMETRIC_RGB',PHOTO_PHOTOMETRIC_RGB);
    AddConstant('PHOTO_PHOTOMETRIC_YCBCR',PHOTO_PHOTOMETRIC_YCBCR);
    AddConstant('PHOTO_PROGRAMMODE_NOTDEFINED',PHOTO_PROGRAMMODE_NOTDEFINED);
    AddConstant('PHOTO_PROGRAMMODE_MANUAL',PHOTO_PROGRAMMODE_MANUAL);
    AddConstant('PHOTO_PROGRAMMODE_NORMAL',PHOTO_PROGRAMMODE_NORMAL);
    AddConstant('PHOTO_PROGRAMMODE_APERTURE',PHOTO_PROGRAMMODE_APERTURE);
    AddConstant('PHOTO_PROGRAMMODE_SHUTTER',PHOTO_PROGRAMMODE_SHUTTER);
    AddConstant('PHOTO_PROGRAMMODE_CREATIVE',PHOTO_PROGRAMMODE_CREATIVE);
    AddConstant('PHOTO_PROGRAMMODE_ACTION',PHOTO_PROGRAMMODE_ACTION);
    AddConstant('PHOTO_PROGRAMMODE_PORTRAIT',PHOTO_PROGRAMMODE_PORTRAIT);
    AddConstant('PHOTO_PROGRAMMODE_LANDSCAPE',PHOTO_PROGRAMMODE_LANDSCAPE);
    AddConstant('PHOTO_SATURATION_NORMAL',PHOTO_SATURATION_NORMAL);
    AddConstant('PHOTO_SATURATION_LOW',PHOTO_SATURATION_LOW);
    AddConstant('PHOTO_SATURATION_HIGH',PHOTO_SATURATION_HIGH);
    AddConstant('PHOTO_SHARPNESS_NORMAL',PHOTO_SHARPNESS_NORMAL);
    AddConstant('PHOTO_SHARPNESS_SOFT',PHOTO_SHARPNESS_SOFT);
    AddConstant('PHOTO_SHARPNESS_HARD',PHOTO_SHARPNESS_HARD);
    AddConstant('PHOTO_WHITEBALANCE_AUTO',PHOTO_WHITEBALANCE_AUTO);
    AddConstant('PHOTO_WHITEBALANCE_MANUAL',PHOTO_WHITEBALANCE_MANUAL);
    AddConstant('SFGAOSTR_FILESYS',SFGAOSTR_FILESYS);
    AddConstant('SFGAOSTR_FILEANC',SFGAOSTR_FILEANC);
    AddConstant('SFGAOSTR_STORAGEANC',SFGAOSTR_STORAGEANC);
    AddConstant('SFGAOSTR_STREAM',SFGAOSTR_STREAM);
    AddConstant('SFGAOSTR_LINK',SFGAOSTR_LINK);
    AddConstant('SFGAOSTR_HIDDEN',SFGAOSTR_HIDDEN);
    AddConstant('SFGAOSTR_SUPERHIDDEN',SFGAOSTR_SUPERHIDDEN);
    AddConstant('SFGAOSTR_FOLDER',SFGAOSTR_FOLDER);
    AddConstant('SFGAOSTR_NONENUM',SFGAOSTR_NONENUM);
    AddConstant('SFGAOSTR_BROWSABLE',SFGAOSTR_BROWSABLE);
    AddConstant('SYNC_HANDLERTYPE_OTHER',SYNC_HANDLERTYPE_OTHER);
    AddConstant('SYNC_HANDLERTYPE_PROGRAMS',SYNC_HANDLERTYPE_PROGRAMS);
    AddConstant('SYNC_HANDLERTYPE_DEVICES',SYNC_HANDLERTYPE_DEVICES);
    AddConstant('SYNC_HANDLERTYPE_FOLDERS',SYNC_HANDLERTYPE_FOLDERS);
    AddConstant('SYNC_HANDLERTYPE_WEBSERVICES',SYNC_HANDLERTYPE_WEBSERVICES);
    AddConstant('SYNC_HANDLERTYPE_COMPUTERS',SYNC_HANDLERTYPE_COMPUTERS);
    AddConstant('SYNC_STATE_NOTSETUP',SYNC_STATE_NOTSETUP);
    AddConstant('SYNC_STATE_SYNCNOTRUN',SYNC_STATE_SYNCNOTRUN);
    AddConstant('SYNC_STATE_IDLE',SYNC_STATE_IDLE);
    AddConstant('SYNC_STATE_PENDING',SYNC_STATE_PENDING);
    AddConstant('SYNC_STATE_SYNCING',SYNC_STATE_SYNCING);
  end;
end;

class function TatPropKeyLibrary.LibraryName: string;
begin
  result := 'PropKey';
end;

initialization
  RegisterScripterLibrary(TatPropKeyLibrary, True);

{$WARNINGS ON}

end.

