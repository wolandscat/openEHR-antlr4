package org.openehr.reader_adl14;

import org.junit.jupiter.api.Test;
import org.openehr.antlr4.ReaderTestUtil;
import org.openehr.elReader.ElReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class Adl14ReaderTest {

    private static final Logger log = LoggerFactory.getLogger(Adl14ReaderTest.class);

    @Test
    public void testAllAdl14() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("adl", "adl14", new Adl14Reader((false, false), this.getClass());
    }

}