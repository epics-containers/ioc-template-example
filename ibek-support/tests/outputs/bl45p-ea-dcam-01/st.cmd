# EPICS IOC Startup Script generated by https://github.com/epics-containers/ibek

cd "/epics/ioc"

epicsEnvSet EPICS_CA_MAX_ARRAY_BYTES 6000000

dbLoadDatabase dbd/ioc.dbd
ioc_registerRecordDeviceDriver pdbbase

callbackSetQueueSize(10000)
# aravisConfig(const char *portName, const char *cameraName, size_t maxMemory, int priority, int stackSize)
aravisConfig("DET.DET", "bl45p-ea-detector-01", -1, 0, 1)
# NDROIConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr, maxBuffers, maxMemory, priority, stackSize, maxThreads)
NDROIConfigure("DET.roi", 250, 0, "DET.DET", 0, 0, 0, 0, 0, 1)
# ADCore path for manual NDTimeSeries.template to find base plugin template
epicsEnvSet "EPICS_DB_INCLUDE_PATH", "$(ADCORE)/db"
# NDStatsConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr, maxBuffers, maxMemory, priority, stackSize, maxThreads)
NDStatsConfigure("DET.stat", 250, 0, "DET.DET", 0, 0, 0, 0, 0, 1)
# NDTimeSeriesConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr, maxSignals)
NDTimeSeriesConfigure("DET.stat_TS", 250, 0, "DET.stat", 1, 23)
# Load time series records
dbLoadRecords("$(ADCORE)/db/NDTimeSeries.template",  "P=BL45P-EA-MAP-01,R=:STAT:, PORT=DET.stat ,ADDR=0,TIMEOUT=1,NDARRAY_PORT=DET.DET,NDARRAY_ADDR=0,NCHANS=20000,ENABLED=0")
# NDStdArraysConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr, maxBuffers, maxMemory, priority, stackSize, maxThreads)
NDStdArraysConfigure("DET.arr", 2, 0, "DET.roi", 0, 0, 0, 0, 0, 1)
# NDProcessConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr)
NDProcessConfigure("DET.proc", 250, 0, "DET.DET", 0)
# NDFileTIFFConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr)
NDFileTIFFConfigure("DET.tiff", 250, 0, "DET.DET", 0)
# NDFileHDF5Configure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr)
NDFileHDF5Configure("DET.hdf", 250, 0, "DET.DET", 0)
# NDCircularBuffConfigure(portName, queueSize, blockingCallbacks,
NDCircularBuffConfigure(
# NDPosPluginConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr, maxBuffers, maxMemory, priority, stackSize)
NDPosPluginConfigure("DET.POS", 1000, 0, "DET.DET", 0, 0, 0, 0, 0)
# NDPvaConfigure(portName, queueSize, blockingCallbacks, NDArrayPort, NDArrayAddr, pvName, maxBuffers, maxMemory, priority, stackSize)
NDPvaConfigure("DIFF.PVA", 2, 0, "DET.DET", 0, BL45P-EA-MAP-01:TX:PVA, 0, 0, 0, 0)
startPVAServer

dbLoadRecords /ioc.db
iocInit

