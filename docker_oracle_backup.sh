#!/bin/bash
docker exec -it oracle /bin/bash -c "expdp system/oracle  DUMPFILE=test-$(date +%Y%m%d).DMP logfile=test-$(date +%Y%m%d%H).LOG version=11.2 schemas=test directory=belirledigindizin"
docker cp oracle:/tmp/test-$(date +%Y%m%d).DMP /uygulama/yedek/oracle_backups
docker exec -it oracle /bin/bash -c "rm -rf /tmp/test-$(date +%Y%m%d).DMP /tmp/test/ORACLELOCAL-$(date +%Y%m%d).LOG" 
