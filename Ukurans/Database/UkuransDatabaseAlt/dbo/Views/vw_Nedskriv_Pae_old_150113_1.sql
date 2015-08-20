
CREATE view [dbo].[vw_Nedskriv_Pae_old_150113] 
as
select 
ftb.Dim_Fabrik, ftb.Dim_Materiale, ftb.Materiale, ftb.Beholdning,
ftb.Vaerdi_GP, ftb.GlidGnsPris, vwnlpa.LitraGr2, vwndpa.LangNedskrPct, vwnrpa.RaekkeNedskrPct, vwnlpa.LitraNedskrPct, vwnspa.StatusNedskrPct
,Case		When	vwnspa.StatusNedskrPct	Is Null
				Then	Case	When	vwndpa.LangNedskrPct	Is Null
						Then	Case	When	vwnrpa.RaekkeNedskrPct Is Null
								Then	Case	When	vwnlpa.LitraNedskrPct	<	0
										Then	'Litr'
										Else	'Uned'
									End
								Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
										Then	'Litr'
										Else	'Rækk'
									End
							End
						Else	Case	When	vwnrpa.RaekkeNedskrPct Is null
								Then	Case	When	vwnlpa.LitraNedskrPct	<	vwndpa.LangNedskrPct
										Then	'Litr'
										Else	'Lang'
									End
								Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
										Then	'Litr'
										Else	'Rækk'
									End
							End
					End				
				Else	Case	When	vwndpa.LangNedskrPct	Is Null
						Then	Case	When	vwnspa.StatusNedskrPct		<	vwnrpa.RaekkeNedskrPct
								Then	Case	When	vwnlpa.LitraNedskrPct	<	vwnspa.StatusNedskrPct
										Then	'Litr'
										Else	'Stat'
									End
								Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
										Then	'Litr'
										Else	'Rækk'
									End
							End
						Else	Case	When	vwnspa.StatusNedskrPct		<	vwndpa.LangNedskrPct
								Then	Case	When	vwnlpa.LitraNedskrPct	<	vwnspa.StatusNedskrPct
										Then	'Litr'
										Else	'Stat'
									End	
								Else	Case	When	vwnlpa.LitraNedskrPct	<	vwndpa.LangNedskrPct
										Then	'Litr'
										Else	'Lang'
									End
							End	
					End
	End
		As [FLNType]
,Case		When	vwnspa.StatusNedskrPct	Is Null
				Then	Case	When	vwndpa.LangNedskrPct	Is Null
								Then	Case	When	vwnrpa.RaekkeNedskrPct Is Null
												Then	Case	When	vwnlpa.LitraNedskrPct	<	0
																Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																Else	0
														End
												Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
																Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																Else	vwnrpa.RaekkeNedskrPct * ftb.Vaerdi_GP
														End
										End
								
								Else	Case	When	vwnrpa.RaekkeNedskrPct Is null
												Then	Case	When	vwnlpa.LitraNedskrPct	<	vwndpa.LangNedskrPct
																Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																Else	vwndpa.LangNedskrPct * ftb.Vaerdi_GP
														End
												Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
																Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																Else	vwnrpa.RaekkeNedskrPct * ftb.Vaerdi_GP
														End
										End
						End				
				Else	Case	When	vwndpa.LangNedskrPct	Is Null
								Then	Case	When	vwnspa.StatusNedskrPct		<	vwnrpa.RaekkeNedskrPct
												Then	Case	When	vwnlpa.LitraNedskrPct	<	vwnspa.StatusNedskrPct
																Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																Else	vwnspa.StatusNedskrPct * ftb.Vaerdi_GP
														End
												Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
																Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																Else	vwnrpa.RaekkeNedskrPct * ftb.Vaerdi_GP
														End
										End
								Else	Case	When	vwnspa.StatusNedskrPct		<	vwndpa.LangNedskrPct
												Then	Case	When	vwnlpa.LitraNedskrPct	<	vwnspa.StatusNedskrPct
																Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																Else	vwnspa.StatusNedskrPct * ftb.Vaerdi_GP
														End	
												Else	Case	When	vwnlpa.LitraNedskrPct	<	vwndpa.LangNedskrPct
																Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																Else	vwndpa.LangNedskrPct * ftb.Vaerdi_GP
														End
										End	
						End			
		End
	As [LogNedBruttoPae] --convert(datetime, substring(replace(convert(varchar, dm.gyldigfradato, 102), '.', '-'), 1, 8) + '01') 
,Case When vwnlpa.FTrDato 
					 < cast(( select Vaerdi from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')as datetime)+1 - 1096	-- oprindelig antal 1095 
						Or vwnlpa.FTrDato Is Null
				Then	0
				Else	-Case		When	vwnspa.StatusNedskrPct	Is Null 
									Then	Case	When	vwndpa.LangNedskrPct	Is Null
													Then	Case	When	vwnrpa.RaekkeNedskrPct Is Null
																	Then	Case	When	vwnlpa.LitraNedskrPct	<	0
																					Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																					Else	0
																			End
																	Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
																					Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																					Else	vwnrpa.RaekkeNedskrPct * ftb.Vaerdi_GP
																			End
															End
											
													Else	Case	When	vwnrpa.RaekkeNedskrPct Is null
																	Then	Case	When	vwnlpa.LitraNedskrPct	<	vwndpa.LangNedskrPct
																					Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																					Else	vwndpa.LangNedskrPct * ftb.Vaerdi_GP
																			End
																	Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
																					Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																					Else	vwnrpa.RaekkeNedskrPct * ftb.Vaerdi_GP
																			End
															End
											End				
									Else	Case	When	vwndpa.LangNedskrPct	Is Null
													Then	Case	When	vwnspa.StatusNedskrPct		<	vwnrpa.RaekkeNedskrPct
																	Then	Case	When	vwnlpa.LitraNedskrPct	<	vwnspa.StatusNedskrPct
																					Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																					Else	vwnspa.StatusNedskrPct * ftb.Vaerdi_GP
																			End
																	Else	Case	When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
																					Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																					Else	vwnrpa.RaekkeNedskrPct * ftb.Vaerdi_GP
																			End
															End
													Else	Case	When	vwnspa.StatusNedskrPct		<	vwndpa.LangNedskrPct
																	Then	Case	When	vwnlpa.LitraNedskrPct	<	vwnspa.StatusNedskrPct
																					Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																					Else	vwnspa.StatusNedskrPct * ftb.Vaerdi_GP
																			End	
																	Else	Case	When	vwnlpa.LitraNedskrPct	<	vwndpa.LangNedskrPct
																					Then	vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
																					Else	vwndpa.LangNedskrPct * ftb.Vaerdi_GP
																			End
															End	
											End			
						End
		End
		+	Case		When	vwnlpa.FTrDato
								>= cast(( select Vaerdi from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')as datetime)+1 - 1096 
						Then	case	When	vwnlpa.LitraNedskrPct	<	0 
										Then vwnlpa.LitraNedskrPct * ftb.Vaerdi_GP
										Else 0 
								End
			End					
As [NedKorrNytMatPae]
,Case When fti12.UltBehIndk12mdVd Is Null
      Then 0
      Else -Case When	vwnspa.StatusNedskrPct	Is Null 
				 Then	Case When	vwndpa.LangNedskrPct	Is Null
							 Then Case When	vwnrpa.RaekkeNedskrPct Is Null
									   Then	0
									   Else	Case When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
												 Then	0 
												 Else vwnrpa.RaekkeNedskrPct * fti12.UltBehIndk12mdVd--ftb.Vaerdi_GP
												 End
									   End
							 Else	Case When	vwnrpa.RaekkeNedskrPct Is null
										 Then	Case When	vwnlpa.LitraNedskrPct	<	vwndpa.LangNedskrPct
													 Then	0 
													 Else	vwndpa.LangNedskrPct * fti12.UltBehIndk12mdVd--ftb.Vaerdi_GP
													 End
										 Else	Case When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
													 Then	0 
													 Else	vwnrpa.RaekkeNedskrPct * fti12.UltBehIndk12mdVd--ftb.Vaerdi_GP
													 End
										 End
							 End
				 Else	Case When	vwndpa.LangNedskrPct	Is Null
							 Then	Case When	vwnspa.StatusNedskrPct		<	vwnrpa.RaekkeNedskrPct
										 Then	Case When	vwnlpa.LitraNedskrPct	<	vwnspa.StatusNedskrPct
													 Then	0 
													 Else	vwnspa.StatusNedskrPct * fti12.UltBehIndk12mdVd--ftb.Vaerdi_GP
													 End
										 Else	Case When	vwnlpa.LitraNedskrPct	<	vwnrpa.RaekkeNedskrPct
													 Then	0 
													 Else	vwnrpa.RaekkeNedskrPct * fti12.UltBehIndk12mdVd--ftb.Vaerdi_GP
													 End
										 End
							 Else	Case When	vwnspa.StatusNedskrPct		<	vwndpa.LangNedskrPct
										 Then	Case When	vwnlpa.LitraNedskrPct	<	vwnspa.StatusNedskrPct
													 Then	0 
													 Else	vwnspa.StatusNedskrPct * fti12.UltBehIndk12mdVd--ftb.Vaerdi_GP
													 End	
										 Else	Case When	vwnlpa.LitraNedskrPct	<	vwndpa.LangNedskrPct
													 Then	0 
													 Else	vwndpa.LangNedskrPct * fti12.UltBehIndk12mdVd--ftb.Vaerdi_GP
													 End
										 End	
							 End			
				 End
 end
 -- / 	ftb.Beholdning * fti12.UltBehIndk12mdMgd
As [NedKorrIndkPae]

from (select Dim_Fabrik, Materiale,Dim_Materiale, Dim_Tid, Vaerdi_GP, Beholdning, GlidGnsPris, Vaerdi_SP
      from edw.FT_Beholdning where Dim_Tid = ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')) ftb
left join dbo.vw_NedskrSfaStatPae vwnspa 
on ftb.Dim_Materiale = vwnspa.Dim_Materiale
left join dbo.vw_NedskrSfaDUFPae vwndpa 
on ftb.Dim_Materiale = vwndpa.Dim_Materiale
left join dbo.vw_NedskrSfaLitraPae vwnlpa
on ftb.Materiale = vwnlpa.Materiale
left join dbo.vw_NedskrSfaRIDPae vwnrpa
on ftb.Materiale = vwnrpa.Materiale 
left join ((Select a.[Dim_Fabrik],a.[Materiale],a.[Dim_Tid],a.[BrutIndk12mdMgd],a.[UltBehIndk12mdMgd]
			,a.[UltBehIndk12mdVd],a.[Dim_Materiale]
			From [edw].[FT_Indk12md] a
			Left join edw.Dim_Materiale b on a.Dim_Materiale = b.PK_ID
			Left join edw.Dim_Litra c on b.Litra_PKID = c.PK_ID
			Where Dim_Tid = (select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
			and c.LitraNedskrPct is null)
			) fti12
on ftb.Dim_Fabrik = fti12.Dim_Fabrik and ftb.Dim_Materiale = fti12.Dim_Materiale and ftb.Dim_Tid = fti12.Dim_Tid