package org.openehr.commonReader;

import com.google.common.base.Charsets;
import org.antlr.v4.runtime.CharStreams;
import org.apache.commons.io.input.BOMInputStream;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.openehr.antlr4.ReaderTestUtil;
import org.openehr.belReader.BelReader;
import org.openehr.cadlReader.Cadl2Reader;
import org.openehr.common.SyntaxReader;
import org.openehr.elReader.ElReader;
import org.openehr.odinReader.OdinReader;
import org.reflections.Reflections;
import org.reflections.scanners.Scanners;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class CommonReaderTest {

    private static final Logger log = LoggerFactory.getLogger(CommonReaderTest.class);

    @Test
    public void testAllOdin() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("odin", "odin", new OdinReader (false, false), this.getClass());
    }

    @Test
    public void testAllCadl2() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("cadl", "cadl2", new Cadl2Reader(false, false), this.getClass());
    }


    /**
     * Test BMM-based EL grammar
     * @throws IOException
     */
    @Test
    public void testAllEl() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("el", "el", new ElReader(false, false), this.getClass());
    }

    /**
     * Test old BEL grammar
     * @throws IOException
     */
    @Test
    public void testAllBel() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("el", "bel", new BelReader(false, false), this.getClass());
    }

}