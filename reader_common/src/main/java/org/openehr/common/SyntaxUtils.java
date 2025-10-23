package org.openehr.common;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.List;

public class SyntaxUtils {

    static Integer TEXT_SECTION_SIZE = 10000;

    /**
     * Efficiently crunch a List<TerminalNode> containing lines of text
     * into a single string
     */
    public static CharStream textToCharStream (List<TerminalNode> nodeList) {
        StringBuilder sb = new StringBuilder(TEXT_SECTION_SIZE);
        for (TerminalNode node: nodeList)
            sb.append(node.getText());
        return CharStreams.fromString (sb.toString());
    }

}
