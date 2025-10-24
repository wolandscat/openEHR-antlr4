package org.openehr.antlr4;

import com.google.common.base.Charsets;
import org.antlr.v4.runtime.CharStreams;
import org.apache.commons.io.input.BOMInputStream;
import org.junit.jupiter.api.Assertions;
import org.openehr.common.SyntaxReader;
import org.reflections.Reflections;
import org.reflections.scanners.Scanners;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.reflections.util.FilterBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class ReaderTestUtil {

    /**
     * Run test on pass and fail groups of artefacts under a specific resource directory
     * and having a specific file extension.
     * @param fileExt the file extension to match; don't include the '.'!
     * @param artefactType a top-level name under test/resources.
     * @param reader an instantiated artefact reader of the correct type for the artefacts.
     * @throws IOException
     */
    public void runTest (String fileExt, String artefactType, SyntaxReader<?,?> reader, Class<?> sourceModuleClass) throws IOException {
        Reflections reflections;
        List<String> passPaths, failPaths;

        // find the paths in callers resources area
        ClassLoader classLoader = sourceModuleClass.getClassLoader();
        reflections = new Reflections(
                new ConfigurationBuilder()
                        .addClassLoaders(classLoader)
                        .forPackage(artefactType + ".pass")
                        .filterInputsBy(new FilterBuilder().includePackage(artefactType + ".pass"))
                        .setScanners(Scanners.Resources)
        );
        passPaths = new ArrayList<>(reflections.getResources (Pattern.compile(".*\\." + fileExt)));

//        passPaths = new ArrayList<>(reflections.getResources (Pattern.compile(".*anatomical_location_precise\\.v0\\." + fileExt)));

        int passErrorCount = executeTestGroup (passPaths, artefactType, reader);
        int passGroupCount = passPaths.size();

        // run failing tests;
        // TODO: many of these tests will pass pure parsing, until
        // we implement validation passes. Most of this should be in archie.
        reflections = new Reflections(
                new ConfigurationBuilder()
                        .addClassLoaders(classLoader)
                        .forPackage(artefactType + ".fail")
                        .filterInputsBy(new FilterBuilder().includePackage(artefactType + ".fail"))
                        .setScanners(Scanners.Resources)
        );
        failPaths = new ArrayList<>(reflections.getResources (Pattern.compile(".*\\." + fileExt)));
        int failErrorCount = executeTestGroup (failPaths, artefactType, reader);
        int failGroupCount = failPaths.size();

        if (passErrorCount > 0 || failErrorCount != failPaths.size())
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