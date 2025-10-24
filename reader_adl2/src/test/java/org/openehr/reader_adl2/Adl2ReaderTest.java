package org.openehr.reader_adl2;

import com.google.common.base.Charsets;
import org.antlr.v4.runtime.CharStreams;
import org.apache.commons.io.input.BOMInputStream;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
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

public class Adl2ReaderTest {

    private static final Logger log = LoggerFactory.getLogger(Adl2ReaderTest.class);

    @Test
    public void testAllAdl2() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("adls", "adl2", new Adl2Reader(false, false), this.getClass());
    }

    @Test
    public void testAllAdl3() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("adls", "adl3", new Adl2Reader(false, false), this.getClass());
    }

}