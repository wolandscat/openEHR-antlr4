package org.openehr.reader_aql;

import com.google.common.base.Charsets;
import org.antlr.v4.runtime.CharStreams;
import org.apache.commons.io.input.BOMInputStream;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.openehr.antlr4.ReaderTestUtil;
import org.openehr.common.SyntaxReader;
import org.openehr.elReader.ElReader;
import org.openehr.parser_aql.AqlReader;
import org.reflections.Reflections;
import org.reflections.scanners.Scanners;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class AqlReaderTest {

    private static final Logger log = LoggerFactory.getLogger(AqlReaderTest.class);

    @Test
    public void testAllAql() throws IOException {
        ReaderTestUtil testRunner = new ReaderTestUtil();
        testRunner.runTest ("aql", "aql", new AqlReader(false, false), this.getClass());
    }

}
