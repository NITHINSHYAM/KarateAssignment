package UserExample;
import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.Assert.*;

@KarateOptions(tags = " @fetchUser")
public class TestRunner {

      /*  @BeforeClass
        public static void before()
        {

                String env = System.getProperty("karate.env");
                System.out.println("environment is:" +env);
        }*/

    @Test
    public void testRunner(){
        String karateOutputPath = "target/surefire-reports";
        Results results = Runner.parallel(getClass(), 1, karateOutputPath);
        generateReport(results.getReportDir());
        assertTrue(results.getErrorMessages(),results.getFailCount()==0);
    }

    private static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "mobile");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}
