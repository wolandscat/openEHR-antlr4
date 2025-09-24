package org.openehr.adlReader;

import com.google.common.base.Charsets;
import org.antlr.v4.runtime.CharStreams;
import org.apache.commons.io.input.BOMInputStream;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.openehr.aqlReader.AqlReader;
import org.openehr.belReader.BelReader;
import org.openehr.bmmlReader.BmmlReader;
import org.openehr.cadlReader.Cadl14Reader;
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

public class Adl2ReaderTest {

    private static final Logger log = LoggerFactory.getLogger(Adl2ReaderTest.class);

    @Test
    public void testAllOdin() throws IOException {
        runTest ("odin", "odin", new OdinReader (false, false));
    }

    @Test
    public void testAllCadl2() throws IOException {
        runTest ("cadl", "cadl2", new Cadl2Reader(false, false));
    }

    @Test
    public void testAllCadl14() throws IOException {
        runTest ("cadl", "cadl14", new Cadl14Reader(false, false));
    }

    /**
     * Test BMM-based EL grammar
     * @throws IOException
     */
    @Test
    public void testAllEl() throws IOException {
        runTest ("el", "el", new ElReader(false, false));
    }

    /**
     * Test BMML grammar
     * @throws IOException
     */
    @Test
    public void testAllBmml() throws IOException {
        runTest ("bmml", "bmml", new BmmlReader(false, false));
    }

    /**
     * Test old BEL grammar
     * @throws IOException
     */
    @Test
    public void testAllBel() throws IOException {
        runTest ("el", "bel", new BelReader(false, false));
    }

    @Test
    public void testAllAql() throws IOException {
        runTest ("aql", "aql", new AqlReader(false, false));
    }

    @Test
    public void testAllAdl2() throws IOException {
        runTest ("adls", "adl2", new Adl2Reader(false, false));
    }

    @Test
    public void testAllAdl3() throws IOException {
        runTest ("adls", "adl3", new Adl2Reader(false, false));
    }

    @Test
    public void testAllAdl14() throws IOException {
        runTest ("adl", "adl14", new Adl14Reader(false, false));
    }

    /**
     * Run test on pass and fail groups of artefacts under a specific resource directory
     * and having a specific file extension.
     * @param fileExt the file extension to match; don't include the '.'!
     * @param artefactType a top-level name under test/resources.
     * @param reader an instantiated artefact reader of the correct type for the artefacts.
     * @throws IOException
     */
    private void runTest (String fileExt, String artefactType, SyntaxReader<?,?> reader) throws IOException {
        Reflections reflections;
        List<String> paths;

        // run passing tests
        reflections = new Reflections (artefactType + ".pass", Scanners.Resources);
        paths = new ArrayList<>(reflections.getResources (Pattern.compile(".*\\." + fileExt)));

//        paths = new ArrayList<>(reflections.getResources (Pattern.compile(".*anatomical_location_precise\\.v0\\." + fileExt)));
        int passErrorCount = executeTestGroup ( paths, artefactType, reader);
        int passGroupCount = paths.size();

        // run failing tests;
        // TODO: many of these tests will pass pure parsing, until
        // we implement validation passes. Most of this should be in archie.
        reflections = new Reflections (artefactType + ".fail", Scanners.Resources);
        paths = new ArrayList<>(reflections.getResources (Pattern.compile(".*\\." + fileExt)));
//        paths = new ArrayList<>(reflections.getResources (Pattern.compile(".*anatomical_location_precise\\.v0\\." + fileExt)));
        int failErrorCount = executeTestGroup ( paths, artefactType, reader);
        int failGroupCount = paths.size();

        if (passErrorCount > 0 || failErrorCount != paths.size())
            Assertions.fail(String.format ("%d files failed from %d in pass group; %d files passed from %d in fail group",
                    passErrorCount, passGroupCount, failGroupCount - failErrorCount, failGroupCount));
    }

    // --------------------------- Implementation ------------------------------

    private int executeTestGroup (List<String> paths, String artefactType, SyntaxReader<?,?> reader) throws IOException {
        int errorCount = 0;
        for (String pathName : paths) {
            try (InputStream stream = getClass().getResourceAsStream("/" + pathName)) {
                reader.read (CharStreams.fromStream(new BOMInputStream(stream), Charsets.UTF_8), artefactType, 0);

                // report results
                if (reader.getErrors().hasErrors()) {
                    errorCount++;
                    System.out.println("ERRORS: ----------------- " + pathName + " ----------------");
                    System.out.println(reader.getErrors().getErrors().get(0).qualifiedMessage()); // first error only
                    System.out.println();
                }
//                if (reader.getErrors().hasWarnings()) {
//                    System.out.println("WARNINGS:  ----------------- " + pathName + " ----------------");
//                    System.out.println(reader.getErrors().getWarnings().get(0).qualifiedMessage()); // first error only
//                    System.out.println();
//                }
            }
        }
        return errorCount;
    }

}