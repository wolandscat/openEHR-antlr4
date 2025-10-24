package org.openehr.reader_adl14;

import com.google.common.base.Charsets;
import org.antlr.v4.runtime.CharStreams;
import org.apache.commons.io.input.BOMInputStream;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.openehr.antlr4.ReaderTestUtil;
import org.openehr.common.SyntaxReader;
import org.openehr.elReader.ElReader;
import org.reflections.Reflections;
import org.reflections.scanners.Scanners;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class Adl14ReaderTest {

    private static final Logger log = LoggerFactory.getLogger(Adl14ReaderTest.class);

    @Test
    public void testAllAdl14() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("adl", "adl14", new ElReader(false, false), this.getClass());
    }

}