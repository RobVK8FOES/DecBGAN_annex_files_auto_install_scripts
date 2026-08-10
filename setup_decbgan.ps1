$UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"

Invoke-WebRequest -Uri "https://www.etsi.org/deliver/etsi_ts/102700_102799/1027440201/01.01.01_60/ts_1027440201v010101p0.zip" -UserAgent $UA -OutFile "ts_1027440201v010101p0.zip"

Invoke-WebRequest -Uri "https://www.etsi.org/deliver/etsi_ts/102700_102799/1027440301/01.01.01_60/ts_1027440301v010101p.pdf" -UserAgent $UA -OutFile "ts_1027440301v010101p.pdf"

Expand-Archive -Path "ts_1027440201v010101p0.zip" -DestinationPath "." -Force

Expand-Archive -Path "ts_1027440201_AnnexC1_v010101p0.zip" -DestinationPath "." -Force

Expand-Archive -Path "ts_1027440201_AnnexC2_v010101p0.zip" -DestinationPath "." -Force

Remove-Item -Path "ts_1027440201*.zip" -Force