addpath('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt');
results = {};
nOk=0; nFail=0;
try
  fprintf(1, '=== [1/26] 02_Box_FoundingDocs__Dissolution_DistributionOfAssets_FlowChart.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\02_Box_FoundingDocs__Dissolution_DistributionOfAssets_FlowChart\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','02_Box_FoundingDocs__Dissolution_DistributionOfAssets_FlowChart.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','02_Box_FoundingDocs__Dissolution_DistributionOfAssets_FlowChart.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [2/26] 21_Dropbox_Religion__Rupnik_Saturno_Clericalism.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\21_Dropbox_Religion__Rupnik_Saturno_Clericalism\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','21_Dropbox_Religion__Rupnik_Saturno_Clericalism.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','21_Dropbox_Religion__Rupnik_Saturno_Clericalism.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [3/26] 12_Dropbox_aReuben__Fall 2018_Math Schedule.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\12_Dropbox_aReuben__Fall 2018_Math Schedule\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','12_Dropbox_aReuben__Fall 2018_Math Schedule.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','12_Dropbox_aReuben__Fall 2018_Math Schedule.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [4/26] 05_Box_Website__Thermometer_Graphic.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\05_Box_Website__Thermometer_Graphic\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','05_Box_Website__Thermometer_Graphic.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','05_Box_Website__Thermometer_Graphic.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [5/26] 11_Dropbox_aEmmerich__Denmark_Pictures.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\11_Dropbox_aEmmerich__Denmark_Pictures\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','11_Dropbox_aEmmerich__Denmark_Pictures.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','11_Dropbox_aEmmerich__Denmark_Pictures.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [6/26] 17_Dropbox_Politics__Meme Creation.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\17_Dropbox_Politics__Meme Creation\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','17_Dropbox_Politics__Meme Creation.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','17_Dropbox_Politics__Meme Creation.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [7/26] 16_Dropbox_Friends__Maile_UMary_Course Plan_TheoMajor_ArtMinor_Graphic.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\16_Dropbox_Friends__Maile_UMary_Course Plan_TheoMajor_ArtMinor_Graphic\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','16_Dropbox_Friends__Maile_UMary_Course Plan_TheoMajor_ArtMinor_Graphic.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','16_Dropbox_Friends__Maile_UMary_Course Plan_TheoMajor_ArtMinor_Graphic.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [8/26] 23_Dropbox_Soccer__SoccerAward.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\23_Dropbox_Soccer__SoccerAward\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','23_Dropbox_Soccer__SoccerAward.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','23_Dropbox_Soccer__SoccerAward.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [9/26] 06_Box_Zeffy__Donation_Form_Question_Discrepencies_by_Link_Type_.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\06_Box_Zeffy__Donation_Form_Question_Discrepencies_by_Link_Type_\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','06_Box_Zeffy__Donation_Form_Question_Discrepencies_by_Link_Type_.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','06_Box_Zeffy__Donation_Form_Question_Discrepencies_by_Link_Type_.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [10/26] 20_Dropbox_Recreation__ExampleItinerary.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\20_Dropbox_Recreation__ExampleItinerary\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','20_Dropbox_Recreation__ExampleItinerary.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','20_Dropbox_Recreation__ExampleItinerary.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [11/26] 18_Dropbox_Poverty_Awareness__Display Board Titles Headers.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\18_Dropbox_Poverty_Awareness__Display Board Titles Headers\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','18_Dropbox_Poverty_Awareness__Display Board Titles Headers.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','18_Dropbox_Poverty_Awareness__Display Board Titles Headers.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [12/26] 26_Dropbox_w-Sandia__Vibrationdata_download.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\26_Dropbox_w-Sandia__Vibrationdata_download\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','26_Dropbox_w-Sandia__Vibrationdata_download.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','26_Dropbox_w-Sandia__Vibrationdata_download.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [13/26] 01_Box_Conferences__SLG_Intro4Scientists.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\01_Box_Conferences__SLG_Intro4Scientists\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','01_Box_Conferences__SLG_Intro4Scientists.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','01_Box_Conferences__SLG_Intro4Scientists.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [14/26] 15_Dropbox_Family__picturesForPuttingAwayClothes.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\15_Dropbox_Family__picturesForPuttingAwayClothes\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','15_Dropbox_Family__picturesForPuttingAwayClothes.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','15_Dropbox_Family__picturesForPuttingAwayClothes.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [15/26] 22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [16/26] 07_Dropbox_a_Chesterton__ChestertonABQ_EmergencyCommunicationOptions_2022-0.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\07_Dropbox_a_Chesterton__ChestertonABQ_EmergencyCommunicationOptions_2022-0\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','07_Dropbox_a_Chesterton__ChestertonABQ_EmergencyCommunicationOptions_2022-0.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','07_Dropbox_a_Chesterton__ChestertonABQ_EmergencyCommunicationOptions_2022-0.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [17/26] 24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [18/26] 03_Box_Secretary__ArtNonprofit_Info_Planning_Meeting_20201220.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\03_Box_Secretary__ArtNonprofit_Info_Planning_Meeting_20201220\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','03_Box_Secretary__ArtNonprofit_Info_Planning_Meeting_20201220.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','03_Box_Secretary__ArtNonprofit_Info_Planning_Meeting_20201220.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [19/26] 04_Box_Treasurer__SLG_CheckoutDotCom_RequestedInfo_Rev1.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\04_Box_Treasurer__SLG_CheckoutDotCom_RequestedInfo_Rev1\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','04_Box_Treasurer__SLG_CheckoutDotCom_RequestedInfo_Rev1.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','04_Box_Treasurer__SLG_CheckoutDotCom_RequestedInfo_Rev1.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [20/26] 10_Dropbox_aDietrich__Oregon State Report Pictures.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\10_Dropbox_aDietrich__Oregon State Report Pictures\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','10_Dropbox_aDietrich__Oregon State Report Pictures.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','10_Dropbox_aDietrich__Oregon State Report Pictures.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [21/26] 09_Dropbox_aAdela__FairiesAdela.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\09_Dropbox_aAdela__FairiesAdela\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','09_Dropbox_aAdela__FairiesAdela.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','09_Dropbox_aAdela__FairiesAdela.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [22/26] 08_Dropbox_a_Holy_Child__Experiment_14_Atoms_and_Molecules.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\08_Dropbox_a_Holy_Child__Experiment_14_Atoms_and_Molecules\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','08_Dropbox_a_Holy_Child__Experiment_14_Atoms_and_Molecules.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','08_Dropbox_a_Holy_Child__Experiment_14_Atoms_and_Molecules.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [23/26] 19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [24/26] 13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [25/26] 25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
try
  fprintf(1, '=== [26/26] 14_Dropbox_Ethics__High School NFP presentation.pptx ===\n');
  run('C:\Users\dougl\Repos\MSOffice_Grok\Mat2Ppt\examples\recreations\14_Dropbox_Ethics__High School NFP presentation\demo.m');
  nOk = nOk + 1;
  results{end+1} = struct('src','14_Dropbox_Ethics__High School NFP presentation.pptx','ok',true,'err',''); %#ok<SAGROW>
catch ME
  nFail = nFail + 1;
  fprintf(1, 'FAIL %s\n', ME.message);
  results{end+1} = struct('src','14_Dropbox_Ethics__High School NFP presentation.pptx','ok',false,'err',ME.message); %#ok<SAGROW>
end
fprintf(1, '\nRECREATE_BATCH ok=%d fail=%d\n', nOk, nFail);
fid=fopen('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/BATCH_RESULTS.txt','w');
for i=1:numel(results), fprintf(fid,'%s\t%d\t%s\n', results{i}.src, results{i}.ok, results{i}.err); end
fclose(fid);
