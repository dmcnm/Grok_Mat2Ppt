logf = fullfile(fileparts(mfilename('fullpath')), '_batch_09_26_matlab.log');
fid = fopen(logf, 'w');
ok = 0; fail = 0;
try
  fprintf('==== 09_Dropbox_aAdela__FairiesAdela ====\n');
  fprintf(fid, '==== 09_Dropbox_aAdela__FairiesAdela ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/09_Dropbox_aAdela__FairiesAdela/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 09_Dropbox_aAdela__FairiesAdela: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 10_Dropbox_aDietrich__Oregon State Report Pictures ====\n');
  fprintf(fid, '==== 10_Dropbox_aDietrich__Oregon State Report Pictures ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/10_Dropbox_aDietrich__Oregon State Report Pictures/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 10_Dropbox_aDietrich__Oregon State Report Pictures: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 11_Dropbox_aEmmerich__Denmark_Pictures ====\n');
  fprintf(fid, '==== 11_Dropbox_aEmmerich__Denmark_Pictures ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/11_Dropbox_aEmmerich__Denmark_Pictures/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 11_Dropbox_aEmmerich__Denmark_Pictures: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 12_Dropbox_aReuben__Fall 2018_Math Schedule ====\n');
  fprintf(fid, '==== 12_Dropbox_aReuben__Fall 2018_Math Schedule ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/12_Dropbox_aReuben__Fall 2018_Math Schedule/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 12_Dropbox_aReuben__Fall 2018_Math Schedule: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r ====\n');
  fprintf(fid, '==== 13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 13_Dropbox_Education__Engineering_CareerOverview_SHS_DMCoombs_20210407_r: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 14_Dropbox_Ethics__High School NFP presentation ====\n');
  fprintf(fid, '==== 14_Dropbox_Ethics__High School NFP presentation ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/14_Dropbox_Ethics__High School NFP presentation/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 14_Dropbox_Ethics__High School NFP presentation: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 15_Dropbox_Family__picturesForPuttingAwayClothes ====\n');
  fprintf(fid, '==== 15_Dropbox_Family__picturesForPuttingAwayClothes ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/15_Dropbox_Family__picturesForPuttingAwayClothes/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 15_Dropbox_Family__picturesForPuttingAwayClothes: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 16_Dropbox_Friends__Maile_UMary_Course Plan_TheoMajor_ArtMinor_Graphic ====\n');
  fprintf(fid, '==== 16_Dropbox_Friends__Maile_UMary_Course Plan_TheoMajor_ArtMinor_Graphic ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/16_Dropbox_Friends__Maile_UMary_Course Plan_TheoMajor_ArtMinor_Graphic/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 16_Dropbox_Friends__Maile_UMary_Course Plan_TheoMajor_ArtMinor_Graphic: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 17_Dropbox_Politics__Meme Creation ====\n');
  fprintf(fid, '==== 17_Dropbox_Politics__Meme Creation ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/17_Dropbox_Politics__Meme Creation/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 17_Dropbox_Politics__Meme Creation: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 18_Dropbox_Poverty_Awareness__Display Board Titles Headers ====\n');
  fprintf(fid, '==== 18_Dropbox_Poverty_Awareness__Display Board Titles Headers ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/18_Dropbox_Poverty_Awareness__Display Board Titles Headers/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 18_Dropbox_Poverty_Awareness__Display Board Titles Headers: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea ====\n');
  fprintf(fid, '==== 19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 19_Dropbox_Real_Estate__Coombs_500 Chama_Proof that Moving is a Good Idea: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 20_Dropbox_Recreation__ExampleItinerary ====\n');
  fprintf(fid, '==== 20_Dropbox_Recreation__ExampleItinerary ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/20_Dropbox_Recreation__ExampleItinerary/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 20_Dropbox_Recreation__ExampleItinerary: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 21_Dropbox_Religion__Rupnik_Saturno_Clericalism ====\n');
  fprintf(fid, '==== 21_Dropbox_Religion__Rupnik_Saturno_Clericalism ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/21_Dropbox_Religion__Rupnik_Saturno_Clericalism/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 21_Dropbox_Religion__Rupnik_Saturno_Clericalism: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup ====\n');
  fprintf(fid, '==== 22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 22_Dropbox_Sangre_de_Cristo__Aerial_Views_Markup: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 23_Dropbox_Soccer__SoccerAward ====\n');
  fprintf(fid, '==== 23_Dropbox_Soccer__SoccerAward ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/23_Dropbox_Soccer__SoccerAward/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 23_Dropbox_Soccer__SoccerAward: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0 ====\n');
  fprintf(fid, '==== 24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0 ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 24_Dropbox_technology__HCCS_PrinterInstall_20180206_r0: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2 ====\n');
  fprintf(fid, '==== 25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2 ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 25_Dropbox_w-job_search__CES Recap_Modeling_100513_FinalD2: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
try
  fprintf('==== 26_Dropbox_w-Sandia__Vibrationdata_download ====\n');
  fprintf(fid, '==== 26_Dropbox_w-Sandia__Vibrationdata_download ====\n');
  run('C:/Users/dougl/Repos/MSOffice_Grok/Mat2Ppt/examples/recreations/26_Dropbox_w-Sandia__Vibrationdata_download/demo.m');
  ok = ok + 1;
  fprintf(fid, 'OK\n');
catch ME
  fail = fail + 1;
  fprintf(2, 'FAIL 26_Dropbox_w-Sandia__Vibrationdata_download: %s\n', ME.message);
  fprintf(fid, 'FAIL: %s\n', ME.message);
end
fprintf(fid, 'DONE ok=%d fail=%d\n', ok, fail);
fprintf('DONE ok=%d fail=%d\n', ok, fail);
fclose(fid);
