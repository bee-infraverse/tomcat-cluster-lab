import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PrintXmxXms {

    private static final Logger LOGGER = Logger.getLogger(PrintXmxXms.class.getName());

    public static void main(String[] args) {
        int mb = 1024 * 1024;
        MemoryMXBean memoryBean = ManagementFactory.getMemoryMXBean();
        long xmx = memoryBean.getHeapMemoryUsage().getMax() / mb;
        long xms = memoryBean.getHeapMemoryUsage().getInit() / mb;

        LOGGER.log(Level.INFO, "Initial Memory (xms) : {0}mb", xms);
        LOGGER.log(Level.INFO, "Max Memory (xmx) : {0}mb", xmx);
    }
}
