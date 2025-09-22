// Generated from Adl14Parser.g4 by ANTLR 4.9.2
package org.openehr.adlReader;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.openehr.cadlReader.Cadl14Reader;
import org.openehr.antlr4.Adl14Parser;
import org.openehr.antlr4.Adl14ParserListener;
import org.openehr.common.SyntaxUtils;
import org.openehr.belReader.BelReader;
import org.openehr.odinReader.OdinReader;

/**
 * This class provides an empty implementation of {@link Adl14ParserListener},
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
public class Adl14ReaderListener implements Adl14ParserListener {

	public Adl14ReaderListener(boolean logging, boolean keepAntlrErrors, Adl2ReaderErrorCollector errorCollector, int lineOffset) {
		odinReader = new OdinReader(logging, keepAntlrErrors);
		cadl14Reader = new Cadl14Reader(logging, keepAntlrErrors);
		expressionReader = new BelReader(logging, keepAntlrErrors);
		this.errorCollector = errorCollector;
		this.lineOffset = lineOffset;
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterAdlObject(Adl14Parser.AdlObjectContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitAdlObject(Adl14Parser.AdlObjectContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterAuthoredArchetype(Adl14Parser.AuthoredArchetypeContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitAuthoredArchetype(Adl14Parser.AuthoredArchetypeContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterHeader(Adl14Parser.HeaderContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitHeader(Adl14Parser.HeaderContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaData(Adl14Parser.MetaDataContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaData(Adl14Parser.MetaDataContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaDataItem(Adl14Parser.MetaDataItemContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaDataItem(Adl14Parser.MetaDataItemContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaDataValueItem(Adl14Parser.MetaDataValueItemContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaDataValueItem(Adl14Parser.MetaDataValueItemContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaDataFlag(Adl14Parser.MetaDataFlagContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaDataFlag(Adl14Parser.MetaDataFlagContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaDataItemValue(Adl14Parser.MetaDataItemValueContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaDataItemValue(Adl14Parser.MetaDataItemValueContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterSpecializeSection(Adl14Parser.SpecializeSectionContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitSpecializeSection(Adl14Parser.SpecializeSectionContext ctx) { }

	@Override
	public void enterConceptSection(Adl14Parser.ConceptSectionContext ctx) {

	}

	@Override
	public void exitConceptSection(Adl14Parser.ConceptSectionContext ctx) {

	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterLanguageSection (Adl14Parser.LanguageSectionContext ctx) {
		odinReader.read (SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()),
				Adl2ReaderDefinitions.LANGUAGE_SECTION_NAME, ctx.LANGUAGE_HEADER().getSymbol().getLine());
		errorCollector.setLanguageErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitLanguageSection(Adl14Parser.LanguageSectionContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterDescriptionSection(Adl14Parser.DescriptionSectionContext ctx) {
		odinReader.read(SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()),
				Adl2ReaderDefinitions.DESCRIPTION_SECTION_NAME, ctx.DESCRIPTION_HEADER().getSymbol().getLine());
		errorCollector.setDescriptionErrors (odinReader.getErrors());
	}
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitDescriptionSection(Adl14Parser.DescriptionSectionContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterDefinitionSection(Adl14Parser.DefinitionSectionContext ctx) {
		cadl14Reader.read (SyntaxUtils.textToCharStream (ctx.cadlText().CADL_LINE()),
				Adl2ReaderDefinitions.DEFINITION_SECTION_NAME, ctx.DEFINITION_HEADER().getSymbol().getLine());
		errorCollector.setDefinitionErrors (cadl14Reader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitDefinitionSection(Adl14Parser.DefinitionSectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterRulesSection(Adl14Parser.RulesSectionContext ctx) {
		expressionReader.read (SyntaxUtils.textToCharStream (ctx.elText().EL_LINE()),
				Adl2ReaderDefinitions.RULES_SECTION_NAME, ctx.RULES_HEADER().getSymbol().getLine());
		errorCollector.setRulesErrors (expressionReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitRulesSection(Adl14Parser.RulesSectionContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterTerminologySection(Adl14Parser.TerminologySectionContext ctx) {
		odinReader.read (SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()),
				Adl2ReaderDefinitions.TERMINOLOGY_SECTION_NAME, ctx.TERMINOLOGY_HEADER().getSymbol().getLine());
		errorCollector.setTerminologyErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitTerminologySection(Adl14Parser.TerminologySectionContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterAnnotationsSection(Adl14Parser.AnnotationsSectionContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitAnnotationsSection(Adl14Parser.AnnotationsSectionContext ctx) {
		odinReader.read (SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()),
				Adl2ReaderDefinitions.ANNOTATIONS_SECTION_NAME, ctx.ANNOTATIONS_HEADER().getSymbol().getLine());
		errorCollector.setAnnotationsErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterOdinText(Adl14Parser.OdinTextContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitOdinText(Adl14Parser.OdinTextContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterCadlText(Adl14Parser.CadlTextContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitCadlText(Adl14Parser.CadlTextContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterElText(Adl14Parser.ElTextContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitElText(Adl14Parser.ElTextContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterEveryRule(ParserRuleContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitEveryRule(ParserRuleContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void visitTerminal(TerminalNode node) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void visitErrorNode(ErrorNode node) { }

	private final int lineOffset;

	private final OdinReader odinReader;
	private final Cadl14Reader cadl14Reader;
	private final BelReader expressionReader;

	private final Adl2ReaderErrorCollector errorCollector;

}