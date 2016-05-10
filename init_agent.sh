#!/bin/sh

# copy BRTM jars
cp $WILY_HOME/examples/APM/BRTM/ext/*.jar $WILY_HOME/core/ext

# set EM host
sed -Ei "s/introscope.agent.enterprisemanager.transport.tcp.host.DEFAULT=localhost/introscope.agent.enterprisemanager.transport.tcp.host.DEFAULT=$EM_HOST/" $WILY_HOME/core/config/IntroscopeAgent.profile

# set EM port
sed -Ei "s/introscope.agent.enterprisemanager.transport.tcp.port.DEFAULT=5001/introscope.agent.enterprisemanager.transport.tcp.port.DEFAULT=$EM_PORT/" $WILY_HOME/core/config/IntroscopeAgent.profile

# enable BRTM
sed -Ei 's/#introscope.agent.brtm.enabled=false/introscope.agent.brtm.enabled=true/' $WILY_HOME/core/config/IntroscopeAgent.profile
sed -Ei 's/#brtm.pbd/brtm.pbd/' $WILY_HOME/core/config/tomcat-typical.pbl

# now add the APM agent to Tomcat startup parameters
export CATALINA_OPTS="$CATALINA_OPTS -Xmx2048m -javaagent:$WILY_HOME/Agent.jar -Dcom.wily.introscope.agentProfile=$WILY_HOME/core/config/IntroscopeAgent.profile -Dcom.wily.introscope.agent.agentName=$AGENT_NAME"
