GO
/****** Object:  StoredProcedure [dbo].[uspRefreshUserRoles]    Script Date: 3/24/2020 12:48:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspRefreshUserRoles] @UserId nvarchar(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM AspNetUserRoles WHERE UserId=@UserId
	INSERT INTO AspNetUserRoles (UserId,RoleId)  
		  (SELECT ApplicationUserGroups.ApplicationUserId, ApplicationGroupRoles.ApplicationRoleId
                  FROM ApplicationUserGroups
                  INNER JOIN ApplicationGroups
                  ON ApplicationGroups.Id = ApplicationUserGroups.ApplicationGroupId
                  INNER JOIN ApplicationGroupRoles
                  ON ApplicationGroups.Id = ApplicationGroupRoles.ApplicationGroupId  
				  WHERE ApplicationUserGroups.ApplicationUserId = @UserId)
				  EXCEPT SELECT UserId, RoleId FROM AspNetUserRoles
	--(SELECT @UserId, ApplicationRoleId FROM ApplicationGroupRoles WHERE ApplicationGroupId in (SELECT ApplicationUserGroups.ApplicationGroupId FROM ApplicationUserGroups WHERE ApplicationUserId = @UserId)) EXCEPT SELECT UserId, RoleId FROM AspNetUserRoles
END
GO
/****** Object:  StoredProcedure [dbo].[uspRefreshUsersRoles]    Script Date: 3/24/2020 12:48:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspRefreshUsersRoles] @GroupId NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM AspNetUserRoles WHERE UserId IN (SELECT ApplicationUserId FROM ApplicationUserGroups WHERE ApplicationGroupId=@GroupId)
	DECLARE @applicationUserId NVARCHAR(MAX)
	DECLARE @cur CURSOR

	SET @cur = CURSOR FAST_FORWARD FOR 
	SELECT ApplicationUserId FROM ApplicationUserGroups WHERE ApplicationGroupId=@GroupId

	OPEN @cur
	FETCH next FROM @cur into @applicationUserId
	WHILE(@@fetch_status = 0)
	BEGIN
	  INSERT INTO AspNetUserRoles (UserId,RoleId) 
	  (SELECT ApplicationUserGroups.ApplicationUserId, ApplicationGroupRoles.ApplicationRoleId
                  FROM ApplicationUserGroups
                  INNER JOIN ApplicationGroups
                  ON ApplicationGroups.Id = ApplicationUserGroups.ApplicationGroupId
                  INNER JOIN ApplicationGroupRoles
                  ON ApplicationGroups.Id = ApplicationGroupRoles.ApplicationGroupId  
				  WHERE ApplicationUserGroups.ApplicationUserId = @applicationUserId)
				  EXCEPT SELECT UserId, RoleId FROM AspNetUserRoles
	   --(SELECT @applicationUserId, ApplicationGroupRoles.ApplicationRoleId FROM ApplicationGroupRoles WHERE ApplicationGroupId in (SELECT ApplicationUserGroups.ApplicationGroupId FROM ApplicationUserGroups WHERE ApplicationUserId = @applicationUserId)) EXCEPT SELECT UserId, RoleId FROM AspNetUserRoles
	  FETCH NEXT FROM @cur INTO @applicationUserId
	END
	CLOSE @cur
	DEALLOCATE @cur
END
GO
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsEnabled]) VALUES (N'5abbbdd1-ff59-449f-99a1-32c0ac860728', N'philip.gonzalez@example.com', 1, N'AGWa9FBqMOVMsnUzH/+llIpoC+HI7k31Zo6MErSqM/fqzOmBA9zUNRgjCgVKWenuzQ==', N'4ef2d2f8-e9c7-4934-844f-04497226eec3', NULL, 0, 0, NULL, 1, 0, N'philip.gonzalez@example.com', 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsEnabled]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'catherine.bell@example.com', 1, N'AAZEBVPM3J5e6OWLfmAioFVrDfEpzJRFcWgil6WxEOcHC6NAfpYbvoicN28wZObJdg==', N'cd962f41-bc0b-4960-a5e1-7978822374ce', NULL, 0, 0, NULL, 1, 0, N'catherine.bell@example.com', 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsEnabled]) VALUES (N'5e399399-c552-4501-97d4-5f32e93bc05e', N'mark.davis@example.com', 1, N'ABowgPnlhEU0hyTlD1TiXofMKmeNLCYGrIabnohZFPR0FDFi13hchRZ7bd2TresH0A==', N'6eac45fe-b570-49ff-be53-a414bb6a5039', NULL, 0, 0, NULL, 1, 0, N'mark.davis@example.com', 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsEnabled]) VALUES (N'6105247a-5436-4b96-b107-afc99a1cc351', N'admin@example.com', 1, N'AEPNvzOp5JHoDt36sShOpFezov8+DrSLuqV3HE9xY090xhDXR3cGfjAxS8MP5YjnVg==', N'f1d22f72-6a81-4e53-992c-6bc4c6c19f81', N'0796226992', 1, 0, NULL, 1, 0, N'admin@example.com', 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsEnabled]) VALUES (N'b6468a2a-d9fe-4d0f-8e46-da405a9c6ee6', N'george.winter@example.com', 1, N'AJHCqjoWS2DHoS9lxhbwHLWx+XNH4Dlq0LyEixex3Zu7nIBOvHNEuuzXJBOdSVE1SA==', N'4cccd912-aff2-434d-9465-d6a5edc5b7b5', NULL, 0, 0, NULL, 1, 0, N'george.winter@example.com', 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsEnabled]) VALUES (N'd5d440ac-9d23-42f8-a54f-34a9f54255f5', N'william.lake@example.com', 1, N'AIXJdiAFNLSp7idl0PqKYEQc9m78r2kCgefx+7iILrR9erRGMR5eWQk69/R32Egbjw==', N'386aebad-a734-4772-b596-3f0df0c8ca86', NULL, 0, 0, NULL, 1, 0, N'william.lake@example.com', 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsEnabled]) VALUES (N'd7833aa2-2543-4b3e-bd27-7623e486bfd4', N'alan.rose@example.com', 1, N'AASXxf6F/DO72QAbKJgRorAvMgcoPRvGWmm7PTFP6DlmMYrPyigh6jUrMnKA+v8tTQ==', N'0f0b3560-a52f-4c46-adbd-2452e0182cb6', NULL, 0, 0, NULL, 1, 0, N'alan.rose@example.com', 1)
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [IsEnabled]) VALUES (N'f449fc3c-abbf-4147-a1f0-7156fc2cd7cd', N'james.cruz@example.com', 1, N'AAuDZNHg2xRT30qo6XAast4UU9OrPWlrRwDzyxdJr0TNFcX+H4n9gA1WoJg7EA9hEg==', N'3405240b-f607-4bf5-a614-136821442308', NULL, 0, 0, NULL, 1, 0, N'james.cruz@example.com', 1)
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'7476d217-6c08-4974-a77d-932c68e7e1f4', N'Accounting')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'90bda887-a372-45ed-951a-71be9fde534c', N'Admin')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'3d6634f0-5d61-477d-be35-139c7701f8e1', N'Audit')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'1f7e2913-57ed-48fc-8fbe-2dea6fb6edd4', N'CEO')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'c96a76a8-737a-4a76-bddc-17dfa3add7b5', N'CRM')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'868a68d7-7d31-49db-b15a-a33b38cdb2d7', N'Marketing')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'd127267a-fac4-4c7e-9ee5-865fc303a272', N'Operations')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'5b4e101a-a4c4-4e94-972d-a9739bf14399', N'Sales')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'9306c210-00b1-4bb9-8e24-7821dc500ddb', N'Support')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'1f7e2913-57ed-48fc-8fbe-2dea6fb6edd4')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'3d6634f0-5d61-477d-be35-139c7701f8e1')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'5b4e101a-a4c4-4e94-972d-a9739bf14399')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b6468a2a-d9fe-4d0f-8e46-da405a9c6ee6', N'5b4e101a-a4c4-4e94-972d-a9739bf14399')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd7833aa2-2543-4b3e-bd27-7623e486bfd4', N'5b4e101a-a4c4-4e94-972d-a9739bf14399')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f449fc3c-abbf-4147-a1f0-7156fc2cd7cd', N'5b4e101a-a4c4-4e94-972d-a9739bf14399')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5abbbdd1-ff59-449f-99a1-32c0ac860728', N'7476d217-6c08-4974-a77d-932c68e7e1f4')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd7833aa2-2543-4b3e-bd27-7623e486bfd4', N'7476d217-6c08-4974-a77d-932c68e7e1f4')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'868a68d7-7d31-49db-b15a-a33b38cdb2d7')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5e399399-c552-4501-97d4-5f32e93bc05e', N'868a68d7-7d31-49db-b15a-a33b38cdb2d7')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6105247a-5436-4b96-b107-afc99a1cc351', N'90bda887-a372-45ed-951a-71be9fde534c')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'9306c210-00b1-4bb9-8e24-7821dc500ddb')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5abbbdd1-ff59-449f-99a1-32c0ac860728', N'c96a76a8-737a-4a76-bddc-17dfa3add7b5')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'c96a76a8-737a-4a76-bddc-17dfa3add7b5')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5e399399-c552-4501-97d4-5f32e93bc05e', N'c96a76a8-737a-4a76-bddc-17dfa3add7b5')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b6468a2a-d9fe-4d0f-8e46-da405a9c6ee6', N'c96a76a8-737a-4a76-bddc-17dfa3add7b5')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd5d440ac-9d23-42f8-a54f-34a9f54255f5', N'c96a76a8-737a-4a76-bddc-17dfa3add7b5')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd7833aa2-2543-4b3e-bd27-7623e486bfd4', N'c96a76a8-737a-4a76-bddc-17dfa3add7b5')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f449fc3c-abbf-4147-a1f0-7156fc2cd7cd', N'c96a76a8-737a-4a76-bddc-17dfa3add7b5')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'd127267a-fac4-4c7e-9ee5-865fc303a272')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd5d440ac-9d23-42f8-a54f-34a9f54255f5', N'd127267a-fac4-4c7e-9ee5-865fc303a272')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'15460b52-a573-4def-8329-a54ea08a8d6a', N'Operations Managers', N'Operations Managers Group')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'250785b1-3bcd-476e-a64c-58d55fc47002', N'Accounting Managers', N'Accounting Managers Group')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'67f4e9a2-0545-4a2f-9784-40d9b510d35d', N'Support Managers', N'Support Manager Group')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'68287f1d-443b-4521-abd9-a4eb48f91808', N'CEOs', N'CEOs Group')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'89635593-2818-4c46-aa50-2c5d16c4570b', N'CRM Managers', N'CRM Managers Group')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'8f18bcd4-9145-4028-b30b-465eed0c533f', N'Marketing Managers', N'Marketing Managers Group')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'9c51fd4a-369d-49fb-8d9e-84a5d7c8e8b5', N'Administrators', N'Administrators')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'ad35df9e-fe4d-4bdf-bb6d-bb202dffb84a', N'Audit Managers', N'Audit Managers Group')
GO
INSERT [dbo].[ApplicationGroups] ([Id], [Name], [Description]) VALUES (N'bf135745-75d1-44cc-9d71-d0cf3a8b01b5', N'Sales Managers', N'Sales Managers Group')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'c96a76a8-737a-4a76-bddc-17dfa3add7b5', N'15460b52-a573-4def-8329-a54ea08a8d6a')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'd127267a-fac4-4c7e-9ee5-865fc303a272', N'15460b52-a573-4def-8329-a54ea08a8d6a')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'7476d217-6c08-4974-a77d-932c68e7e1f4', N'250785b1-3bcd-476e-a64c-58d55fc47002')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'5b4e101a-a4c4-4e94-972d-a9739bf14399', N'67f4e9a2-0545-4a2f-9784-40d9b510d35d')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'c96a76a8-737a-4a76-bddc-17dfa3add7b5', N'67f4e9a2-0545-4a2f-9784-40d9b510d35d')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'1f7e2913-57ed-48fc-8fbe-2dea6fb6edd4', N'68287f1d-443b-4521-abd9-a4eb48f91808')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'3d6634f0-5d61-477d-be35-139c7701f8e1', N'68287f1d-443b-4521-abd9-a4eb48f91808')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'5b4e101a-a4c4-4e94-972d-a9739bf14399', N'68287f1d-443b-4521-abd9-a4eb48f91808')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'868a68d7-7d31-49db-b15a-a33b38cdb2d7', N'68287f1d-443b-4521-abd9-a4eb48f91808')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'9306c210-00b1-4bb9-8e24-7821dc500ddb', N'68287f1d-443b-4521-abd9-a4eb48f91808')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'c96a76a8-737a-4a76-bddc-17dfa3add7b5', N'68287f1d-443b-4521-abd9-a4eb48f91808')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'd127267a-fac4-4c7e-9ee5-865fc303a272', N'68287f1d-443b-4521-abd9-a4eb48f91808')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'c96a76a8-737a-4a76-bddc-17dfa3add7b5', N'89635593-2818-4c46-aa50-2c5d16c4570b')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'868a68d7-7d31-49db-b15a-a33b38cdb2d7', N'8f18bcd4-9145-4028-b30b-465eed0c533f')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'c96a76a8-737a-4a76-bddc-17dfa3add7b5', N'8f18bcd4-9145-4028-b30b-465eed0c533f')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'90bda887-a372-45ed-951a-71be9fde534c', N'9c51fd4a-369d-49fb-8d9e-84a5d7c8e8b5')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'3d6634f0-5d61-477d-be35-139c7701f8e1', N'ad35df9e-fe4d-4bdf-bb6d-bb202dffb84a')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'c96a76a8-737a-4a76-bddc-17dfa3add7b5', N'ad35df9e-fe4d-4bdf-bb6d-bb202dffb84a')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'5b4e101a-a4c4-4e94-972d-a9739bf14399', N'bf135745-75d1-44cc-9d71-d0cf3a8b01b5')
GO
INSERT [dbo].[ApplicationGroupRoles] ([ApplicationRoleId], [ApplicationGroupId]) VALUES (N'c96a76a8-737a-4a76-bddc-17dfa3add7b5', N'bf135745-75d1-44cc-9d71-d0cf3a8b01b5')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'd5d440ac-9d23-42f8-a54f-34a9f54255f5', N'15460b52-a573-4def-8329-a54ea08a8d6a')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'5abbbdd1-ff59-449f-99a1-32c0ac860728', N'250785b1-3bcd-476e-a64c-58d55fc47002')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'd7833aa2-2543-4b3e-bd27-7623e486bfd4', N'250785b1-3bcd-476e-a64c-58d55fc47002')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'f449fc3c-abbf-4147-a1f0-7156fc2cd7cd', N'67f4e9a2-0545-4a2f-9784-40d9b510d35d')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'5b279b55-f132-4559-8fbe-db3708d0b543', N'68287f1d-443b-4521-abd9-a4eb48f91808')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'5abbbdd1-ff59-449f-99a1-32c0ac860728', N'89635593-2818-4c46-aa50-2c5d16c4570b')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'5e399399-c552-4501-97d4-5f32e93bc05e', N'89635593-2818-4c46-aa50-2c5d16c4570b')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'b6468a2a-d9fe-4d0f-8e46-da405a9c6ee6', N'89635593-2818-4c46-aa50-2c5d16c4570b')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'd5d440ac-9d23-42f8-a54f-34a9f54255f5', N'89635593-2818-4c46-aa50-2c5d16c4570b')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'd7833aa2-2543-4b3e-bd27-7623e486bfd4', N'89635593-2818-4c46-aa50-2c5d16c4570b')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'f449fc3c-abbf-4147-a1f0-7156fc2cd7cd', N'89635593-2818-4c46-aa50-2c5d16c4570b')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'5e399399-c552-4501-97d4-5f32e93bc05e', N'8f18bcd4-9145-4028-b30b-465eed0c533f')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'6105247a-5436-4b96-b107-afc99a1cc351', N'9c51fd4a-369d-49fb-8d9e-84a5d7c8e8b5')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'b6468a2a-d9fe-4d0f-8e46-da405a9c6ee6', N'bf135745-75d1-44cc-9d71-d0cf3a8b01b5')
GO
INSERT [dbo].[ApplicationUserGroups] ([ApplicationUserId], [ApplicationGroupId]) VALUES (N'd7833aa2-2543-4b3e-bd27-7623e486bfd4', N'bf135745-75d1-44cc-9d71-d0cf3a8b01b5')
GO
SET IDENTITY_INSERT [dbo].[Vocabularies] ON 
GO
INSERT [dbo].[Vocabularies] ([Id], [Name], [Ordinal]) VALUES (1, N'Gender', 0)
GO
INSERT [dbo].[Vocabularies] ([Id], [Name], [Ordinal]) VALUES (2, N'Marital Status', 1)
GO
SET IDENTITY_INSERT [dbo].[Vocabularies] OFF
GO
SET IDENTITY_INSERT [dbo].[Terms] ON 
GO
INSERT [dbo].[Terms] ([Id], [Value], [Ordinal], [VocabularyId]) VALUES (1, N'Male', 0, 1)
GO
INSERT [dbo].[Terms] ([Id], [Value], [Ordinal], [VocabularyId]) VALUES (2, N'Female', 1, 1)
GO
INSERT [dbo].[Terms] ([Id], [Value], [Ordinal], [VocabularyId]) VALUES (3, N'Single', 0, 2)
GO
INSERT [dbo].[Terms] ([Id], [Value], [Ordinal], [VocabularyId]) VALUES (4, N'Married', 1, 2)
GO
INSERT [dbo].[Terms] ([Id], [Value], [Ordinal], [VocabularyId]) VALUES (5, N'Divorced', 2, 2)
GO
SET IDENTITY_INSERT [dbo].[Terms] OFF
GO
SET IDENTITY_INSERT [dbo].[DataTypes] ON 
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (12, N'TextBox', 0, 1)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (13, N'RadioList', 1, 8)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (14, N'CheckBox', 0, 6)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (15, N'CheckBoxList', 1, 7)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (16, N'Select', 1, 9)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (17, N'TextArea', 0, 2)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (18, N'Heading', 0, 0)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (19, N'FileUpload', 0, 5)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (20, N'Hidden', 0, 10)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (21, N'DatePicker', 0, 3)
GO
INSERT [dbo].[DataTypes] ([Id], [Name], [HaveChoices], [Ordinal]) VALUES (22, N'DateTimePicker', 0, 4)
GO
SET IDENTITY_INSERT [dbo].[DataTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Properties] ON 
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1, N'TextBox', N'ResponseTitle', N'Response Title', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (3, N'TextBox', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (4, N'TextBox', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (5, N'TextBox', N'Required', N'Required', 3)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (6, N'TextBox', N'RequiredMessage', N'Required Message', 4)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (7, N'RadioList', N'ResponseTitle', N'Response Title', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (8, N'RadioList', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (9, N'RadioList', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (10, N'RadioList', N'Required', N'Required', 3)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (11, N'RadioList', N'RequiredMessage', N'Required Message', 4)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (12, N'RadioList', N'Orientation', N'Orientation', 5)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (13, N'CheckBoxList', N'ResponseTitle', N'Response Title', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (14, N'CheckBoxList', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (15, N'CheckBoxList', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (16, N'CheckBoxList', N'Orientation', N'Orientation', 5)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (17, N'Select', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (18, N'Select', N'ResponseTitle', N'ResponseTitle', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (21, N'Select', N'MultipleSelection', N'Multiple Selection', 5)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (22, N'Select', N'Size', N'Size', 6)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (23, N'Select', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (24, N'TextArea', N'ResponseTitle', N'ResponseTitle', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (25, N'TextArea', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (26, N'TextArea', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (27, N'TextArea', N'Required', N'Required', 3)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (28, N'TextArea', N'RequiredMessage', N'Required Message', 4)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (29, N'CheckBox', N'ResponseTitle', N'ResponseTitle', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (30, N'CheckBox', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (31, N'CheckBox', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (34, N'Heading', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (35, N'Heading', N'Html', N'Html', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (38, N'Select', N'ShowEmptyOption', N'Show Empty Option', 7)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (39, N'Select', N'EmptyOption', N'Empty Option', 8)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (42, N'Select', N'Required', N'Required', 3)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (43, N'Select', N'RequiredMessage', N'Required Message', 4)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1040, N'DatePicker', N'ResponseTitle', N'ResponseTitle', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1041, N'DatePicker', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1042, N'DatePicker', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1043, N'DatePicker', N'Required', N'Required', 3)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1044, N'DatePicker', N'RequiredMessage', N'Required Message', 4)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1058, N'FileUpload', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1059, N'FileUpload', N'ResponseTitle', N'Response Title', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1060, N'FileUpload', N'InvalidExtensionError', N'Invalid Extension Error', 10)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1061, N'FileUpload', N'ValidExtensions', N'Valid Extensions', 9)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1062, N'FileUpload', N'Required', N'Required', 3)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1063, N'FileUpload', N'RequiredMessage', N'Required Message', 4)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1065, N'FileUpload', N'UseMultiple', N'Use Multiple', 11)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1066, N'FileUpload', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1067, N'TextBox', N'RegularExpression', N'Regular Expression', 12)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1068, N'TextBox', N'RegexMessage', N'Regex Message', 13)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1069, N'DatePicker', N'RegularExpression', N'Regular Expression', 12)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1070, N'DatePicker', N'RegexMessage', N'Regex Message', 13)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1071, N'DateTimePicker', N'RegularExpression', N'Regular Expression', 12)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1072, N'DateTimePicker', N'RegexMessage', N'Regex Message', 13)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1073, N'DateTimePicker', N'ResponseTitle', N'Response Title', 1)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1074, N'DateTimePicker', N'Prompt', N'Prompt', 0)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1075, N'DateTimePicker', N'DisplayOrder', N'Display Order', 2)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1076, N'DateTimePicker', N'Required', N'Required', 3)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1077, N'DateTimePicker', N'RequiredMessage', N'Required Message', 4)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1078, N'TextBox', N'InputMask', N'Input Mask', 14)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1079, N'TextBox', N'Placeholder', N'Placeholder', 15)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1080, N'CheckBoxList', N'Required', N'Required', 3)
GO
INSERT [dbo].[Properties] ([Id], [DataType], [Name], [Description], [Ordinal]) VALUES (1081, N'CheckBoxList', N'RequiredMessage', N'Required Message', 4)
GO
SET IDENTITY_INSERT [dbo].[Properties] OFF
GO
SET IDENTITY_INSERT [dbo].[Statuses] ON 
GO
INSERT [dbo].[Statuses] ([Id], [Name]) VALUES (1, N'Active')
GO
INSERT [dbo].[Statuses] ([Id], [Name]) VALUES (2, N'Inactive')
GO
SET IDENTITY_INSERT [dbo].[Statuses] OFF
GO
