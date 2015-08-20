



















CREATE VIEW [dbo].[vw_ManuelVurdering_1]
-- 150727-1: Oprettet for kalkulering af manuel vurderet korrektion pba. vurderet forbrug restperiode frem til prognose (indlagt i edw.PrognManVurdering)
-- 150729-1: Justeret anskaffelsesværdien og beholdning til alene at være den førstegangsanskaffede eller nyligt indkøbte del
-- 150804-1: Indsat case/when der dividerer med 1 når værdien ellers er 0
AS

Select a.FraTil_Tid
	,a.Dim_Fabrik
	,a.Dim_Materiale
	,a.Materiale
	,a.Beholdning
	,a.PrognManVurdMgd
	,a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0) as PrognForbrMgd
	,a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) as PrognBehMgd
	,(a.NytMatKorr + a.IndkLgKorr) / -a.N_Pct as AnskVaerdi
	,(PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) * Isnull(c.GlidGnsPris, 0) as PrognForbrVd
	,(PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) * Isnull(c.GlidGnsPris, 0) * -1 + a.AnskVaerdi as PrognAnskVaerdi
	,case	when	(a.Beholdning - (isnull(a.PrognManVurdMgd, 0) - isnull(b.RegPrognForbrMgd, 0))) <= 0 
			then	Null
			else	(a.Beholdning - (isnull(a.PrognManVurdMgd, 0) - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
					/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
							then 1
							else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
					 end
					* 365
	 end as PrognRID
	 -- Når PrognRID = Null, anvendes nedskrivningsprocent fra edw.PrognManVurdering (a.N_pct)
	 --	Hvis PrognRID er større end nuværende RID, anvendes a.N-pct, ellers ny N-pct baseret på PrognRID (når den er større end 365)
	
	 ,case	when	case	when	a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) <= 0 
							then	0
							else	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
									/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
											then 1
											else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
									 end
									* 365
					end	< a.RID 
			then	case	when	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
									/(a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) -- as PrognForbrMgd
									* 365 > 365
							then	Power(e.RID_NedskrFaktor,
									(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
									/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
											then 1
											else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
									 end
									* 365) - 1
							else	0
					end
			else	case	when	a.RID is null
							then	case	when	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
													/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
															then 1
															else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
													 end
													* 365 > 365
											then	Power(e.RID_NedskrFaktor,
													(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
													/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
															then 1
															else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
													 end
													* 365) - 1
											else	0
									end
							else	a.N_Pct
					end				
	 end as PrognNedskrPct
-- ▼ Den samlede nedskrivning kalkuleres
		,Case	when	a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) <= 0 
				then	0
				else	(PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) * Isnull(c.GlidGnsPris, 0) * -1 + a.AnskVaerdi -- as PrognAnskVaerdi
		 end
		 *	case	when	case	when	a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) <= 0 
							then	0
							else	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
									/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
											then 1
											else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
									 end
									* 365
					end	< a.RID 
			then	case	when	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
									/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
											then 1
											else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
									 end
									* 365 > 365
							then	Power(e.RID_NedskrFaktor,
									(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
									/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
											then 1
											else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
									 end
									* 365) - 1
							else	0
					end
			else	case	when	a.RID is null
							then	case	when	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
													/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
															then 1
															else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
													 end
													* 365 > 365
											then	Power(e.RID_NedskrFaktor,
													(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
													/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
															then 1
															else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
													 end
													* 365) - 1
											else	0
									end
							else	a.N_Pct
					end				
	 end -- as PrognNedskrPct
		as PrognNettoNedskr
	,a.NedskrNetto
-- ▼ Den manuelle tilføjelse kalkuleres	
,case	when	-- hvis der er yderligere nedskrivning
				Case	when	a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) <= 0 
						then	0
						else	(PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) * Isnull(c.GlidGnsPris, 0) * -1 + a.AnskVaerdi -- as PrognAnskVaerdi
				 end
				 *	case	when	case	when	a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) <= 0 
									then	0
									else	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
											/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
													then 1
													else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
											 end
											* 365
							end	< a.RID 
					then	case	when	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
											/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
													then 1
													else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
											 end
											* 365 > 365
									then	Power(e.RID_NedskrFaktor,
											(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
											/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
													then 1
													else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
											 end
											* 365) - 1
									else	0
							end
					else	case	when	a.RID is null
									then	case	when	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
															/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
																	then 1
																	else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
															 end
															* 365 > 365
													then	Power(e.RID_NedskrFaktor,
															(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
															/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
																	then 1
																	else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
															 end
															* 365) - 1
													else	0
											end
									else	a.N_Pct
							end				
			 end -- as PrognNedskrPct
			-- as PrognNettoNedskr
			< a.NedskrNetto
		then	Case	when	a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) <= 0 
						then	0
						else	(PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) * Isnull(c.GlidGnsPris, 0) * -1 + a.AnskVaerdi -- as PrognAnskVaerdi
				 end
				 *	case	when	case	when	a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) <= 0 
									then	0
									else	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
											/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
													then 1
													else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
											 end
											* 365
							end	< a.RID 
					then	case	when	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
											/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
													then 1
													else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
											 end
											* 365 > 365
									then	Power(e.RID_NedskrFaktor,
											(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
											/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
													then 1
													else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
											 end
											* 365) - 1
									else	0
							end
					else	case	when	a.RID is null
									then	case	when	(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
															/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
																	then 1
																	else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
															 end
															* 365 > 365
													then	Power(e.RID_NedskrFaktor,
															(a.Beholdning - (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))) -- as PrognBehMgd	
															/case	when (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0)) = 0	 -- as PrognForbrMgd 
																	then 1
																	else (a.PrognManVurdMgd - isnull(b.RegPrognForbrMgd, 0))
															 end
															* 365) - 1
													else	0
											end
									else	a.N_Pct
							end				
			 end -- as PrognNedskrPct
			-- as PrognNettoNedskr
			- a.NedskrNetto
		else 0
end	as ManVurdNedskNetto
 
--
	
From edw.PrognManVurdering a
-- subquery nuværende forbrugt på det fremtidige prognosetidspunkt
Left join 	( select cast(( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
			+ '-' + ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') as varchar(13)) as FraTil_Tid
			,a.Dim_Fabrik
			,a.Materiale
			,case when sum(a.Maengde)< 0 then sum(a.Maengde) else 0 /* + mængde fra fil */ end as RegPrognForbrMgd
			from [edw].[FT_Transaktioner] a
			left join edw.Dim_BevArt c on a.Dim_BevArt = c.BevArt
			left join edw.PrognManVurdering g on a.Dim_Fabrik = g.Dim_Fabrik and a.Materiale = g.Materiale
			    and g.FraTil_Tid = cast(( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
									+ '-' + ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') as varchar(13))
			
			where c.BevArtType = 'Forbrug'
				and a.RegistrDato >= ((select cast(vaerdi as datetime) from edw.md_styringstabel where parameter = 'PrognBeregDato')-365)
				and a.RegistrDato <	  (select cast(vaerdi as datetime) from edw.md_styringstabel where parameter = 'PrognBeregDato')
				and g.Materiale is not null
			group by a.Dim_Fabrik, a.Materiale
			) b on a.FraTil_Tid = b.FraTil_Tid and a.Dim_Fabrik = b.Dim_Fabrik and a.Materiale = b.Materiale
			
Left join edw.TD23_MatBehGnsGlidIndkPris c on c.Materiale = a.Materiale and c.Fabrik = a.Dim_Fabrik
Left Join [edw].[Dim_Materiale] d on a.Materiale = d.Materiale and d.Aktiv = 'J' 
Left Join edw.[Dim_Litra] e on d.Litra_PKID = e.PK_ID