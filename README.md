
# Use New Relic Infra agent (Fluentbit) to process logs


## Process Log data using LUA filter 
```
[qyang@box19 fluentbit-config]$ cat /etc/newrelic-infra/logging.d/logs.yml
logs:
  - name: fluentbit-test
    fluentbit:
      config_file: /etc/newrelic-infra/logging.d/custom/qiyang.conf
      
cat /etc/newrelic-infra/logging.d/custom/qiyang.conf
[FILTER]
    Name                lua
    Match               *
    Script              /etc/newrelic-infra/logging.d/custom/time.lua
    Call                check_time
```

## Process Multiline Log Data 
```
[qyang@box19 fluentbit-config]$ cat /etc/newrelic-infra/logging.d/logs.yml
logs:
  - name: fluentbit-test
    fluentbit:
      config_file: /etc/newrelic-infra/logging.d/custom/multiline.conf
      parsers_file: /etc/newrelic-infra/logging.d/custom/multiline-parsers.conf
```
