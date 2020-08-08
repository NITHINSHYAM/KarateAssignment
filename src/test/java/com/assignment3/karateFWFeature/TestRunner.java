package com.assignment3.karateFWFeature;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.Assert.assertTrue;

@KarateOptions(
		tags = "@Regression"	//Execute Complete Suite
		//tags = "@Positive"	//Execute All Positive TestCase
		//tags = "@Negative"	//Execute All Negative TestCase
		//tags = {"@CardAuth,@Password,@GET_Account,@GET_Card,@GET_Transactions,@GET_PDT_Eligibility,@POST_PDT_PreProcess"} //Execute All APIs
		//tags = {"@TC_001,@TC_002,@TC_003,@TC_004,@TC_005,@TC_006,@TC_007,@TC_008,@TC_009,@TC_010,@TC_011,@TC_012,@TC_013,@TC_014,@TC_015,@TC_016,@TC_017,@TC_018,@TC_019,@TC_020"} //Execute All TestCase
		)

public class TestRunner {

      /*  @BeforeClass
        public static void before()
        {

                String env = System.getProperty("karate.env");
                System.out.println("environment is:" +env);
        }*/

        @Test
        public void testRunner(){
                String karateOutputPath = "target/cucumber-html-reports";
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
