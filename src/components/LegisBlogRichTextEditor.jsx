import React, { useRef, useEffect, useState } from 'react';
import {
    QueueListIcon,
    ListBulletIcon,
    LinkIcon,
    Bars3CenterLeftIcon,
    PlusCircleIcon
} from '@heroicons/react/24/outline';

const LegisBlogRichTextEditor = ({ value, onChange }) => {
    const editorRef = useRef(null);
    const [toolbarPos, setToolbarPos] = useState({ top: 0, left: 0, visible: false, type: 'selection' });

    useEffect(() => {
        if (editorRef.current && editorRef.current.innerHTML !== value) {
            editorRef.current.innerHTML = value || '<p><br></p>';
        }
    }, []);

    const execCommand = (command, val = null) => {
        document.execCommand(command, false, val);
        if (editorRef.current) {
            onChange(editorRef.current.innerHTML);
        }
    };

    const handleInput = () => {
        if (editorRef.current) {
            onChange(editorRef.current.innerHTML);
        }
    };

    const handleSelection = () => {
        const selection = window.getSelection();
        if (!selection || selection.rangeCount === 0) return;

        const range = selection.getRangeAt(0);

        if (!selection.isCollapsed) {
            // Text is selected -> show formatting toolbar
            const rect = range.getBoundingClientRect();
            setToolbarPos({
                top: rect.top + window.scrollY - 50,
                left: rect.left + window.scrollX + (rect.width / 2) - 80,
                visible: true,
                type: 'format'
            });
        } else {
            // Cursor is collapsed -> show block picker if line is empty-ish
            const node = selection.anchorNode;
            const element = node.nodeType === 3 ? node.parentElement : node;

            if (element && (element.innerText === '\n' || element.innerText === '' || element.innerHTML === '<br>')) {
                const rect = element.getBoundingClientRect();
                setToolbarPos({
                    top: rect.top + window.scrollY,
                    left: rect.left + window.scrollX - 40,
                    visible: true,
                    type: 'block'
                });
            } else {
                setToolbarPos(prev => ({ ...prev, visible: false }));
            }
        }
    };

    useEffect(() => {
        const events = ['mouseup', 'keyup', 'focus'];
        events.forEach(ev => document.addEventListener(ev, handleSelection));
        return () => events.forEach(ev => document.removeEventListener(ev, handleSelection));
    }, []);

    const tools = [
        { label: 'H2', icon: 'H2', action: () => execCommand('formatBlock', 'h2') },
        { label: 'H3', icon: 'H3', action: () => execCommand('formatBlock', 'h3') },
        { label: 'Odstavec', icon: <Bars3CenterLeftIcon className="w-4 h-4" />, action: () => execCommand('formatBlock', 'p') },
        { label: 'Tučné', icon: 'B', action: () => execCommand('bold') },
        { label: 'Kurzíva', icon: 'I', action: () => execCommand('italic') },
        { label: 'Zoznam', icon: <ListBulletIcon className="w-4 h-4" />, action: () => execCommand('insertUnorderedList') },
        {
            label: 'Odkaz', icon: <LinkIcon className="w-4 h-4" />, action: () => {
                const url = prompt('Zadajte URL:');
                if (url) execCommand('createLink', url);
            }
        },
    ];

    return (
        <div className="relative w-full flex flex-col border border-gray-200 rounded-2xl overflow-hidden bg-white shadow-sm ring-1 ring-black/5">
            <style dangerouslySetInnerHTML={{
                __html: `
                .visual-editor-content {
                    min-height: 400px;
                    outline: none;
                    font-size: 1.05rem;
                    line-height: 1.7;
                    color: #4b5563;
                    font-family: 'Catamaran', sans-serif;
                }
                .visual-editor-content h2 {
                    color: #421F10;
                    margin-top: 2rem;
                    margin-bottom: 1rem;
                    font-size: 1.75rem;
                    font-family: 'Martel', serif;
                    font-weight: 700;
                }
                .visual-editor-content h3 {
                    color: #6B3423;
                    margin-top: 1.5rem;
                    margin-bottom: 0.75rem;
                    font-size: 1.4rem;
                    font-family: 'Martel', serif;
                    font-weight: 600;
                }
                .visual-editor-content p {
                    margin-bottom: 1.25rem;
                }
                .visual-editor-content strong {
                    font-weight: 700;
                    color: #111827;
                }
                .visual-editor-content ul {
                    margin: 1.25rem 0;
                    padding-left: 1.5rem;
                    list-style-type: disc;
                }
                .visual-editor-content li {
                    margin-bottom: 0.5rem;
                }
                .visual-editor-content a {
                    color: #F49C12;
                    text-decoration: underline;
                    text-underline-offset: 4px;
                }
                
                .floating-ui {
                    position: fixed;
                    z-index: 1000;
                    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                    pointer-events: auto;
                    transform: translateY(-8px);
                }
                
                .format-toolbar {
                    display: flex;
                    gap: 4px;
                    background: #1e293b;
                    padding: 6px;
                    border-radius: 12px;
                    box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
                    border: 1px solid rgba(255,255,255,0.1);
                }
                
                .format-toolbar button {
                    color: white;
                    min-width: 34px;
                    height: 34px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 8px;
                    font-size: 13px;
                    font-weight: 600;
                    transition: all 0.2s;
                }
                
                .format-toolbar button:hover {
                    background: #334155;
                    color: #F49C12;
                    transform: translateY(-1px);
                }

                .top-toolbar {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 4px;
                    padding: 8px;
                    background: #f8fafc;
                    border-bottom: 1px solid #e2e8f0;
                }

                .top-toolbar button {
                    color: #475569;
                    min-width: 36px;
                    height: 36px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 8px;
                    font-size: 13px;
                    font-weight: 600;
                    transition: all 0.2s;
                    padding: 0 8px;
                }

                .top-toolbar button:hover {
                    background: white;
                    color: #F49C12;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                }
                
                .block-picker {
                    display: flex;
                    align-items: center;
                    color: #94a3b8;
                    cursor: pointer;
                    opacity: 0.5;
                }
                
                .block-picker:hover {
                    opacity: 1;
                    color: #F49C12;
                }

                .visual-editor-content:empty:before {
                    content: 'Začnite písať popis projektu...';
                    color: #94a3b8;
                    pointer-events: none;
                }
            `}} />

            {/* Top Toolbar */}
            <div className="top-toolbar">
                {tools.map((tool, i) => (
                    <button key={i} type="button" onClick={tool.action} title={tool.label}>
                        <span className="flex items-center gap-2">
                            {tool.icon}
                            <span className="text-[10px] uppercase tracking-wider hidden sm:inline">{tool.label}</span>
                        </span>
                    </button>
                ))}
            </div>

            {/* Floating Selection Toolbar */}
            {toolbarPos.visible && (
                <div
                    className="floating-ui animate-in fade-in zoom-in duration-200"
                    style={{
                        top: toolbarPos.top,
                        left: toolbarPos.left,
                    }}
                    onMouseDown={(e) => e.preventDefault()}
                >
                    {toolbarPos.type === 'format' ? (
                        <div className="format-toolbar">
                            {tools.map((tool, i) => (
                                <button key={i} type="button" onClick={tool.action} title={tool.label}>
                                    {tool.icon}
                                </button>
                            ))}
                        </div>
                    ) : (
                        <div className="group relative">
                            <PlusCircleIcon className="w-8 h-8 block-picker shadow-sm bg-white rounded-full" />
                            <div className="hidden group-hover:flex absolute left-10 top-0 format-toolbar">
                                {tools.map((tool, i) => (
                                    <button key={i} type="button" onClick={tool.action} title={tool.label}>
                                        {tool.icon}
                                    </button>
                                ))}
                            </div>
                        </div>
                    )}
                </div>
            )}

            <div
                ref={editorRef}
                contentEditable
                onInput={handleInput}
                className="visual-editor-content p-8 md:p-12 min-h-[500px]"
                placeholder="Popíšte tento projekt..."
            />
        </div>
    );
};

export default LegisBlogRichTextEditor;
