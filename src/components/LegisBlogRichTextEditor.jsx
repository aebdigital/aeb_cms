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
        <div className="relative w-full">
            <style dangerouslySetInnerHTML={{
                __html: `
                .visual-editor-content {
                    --primary-color: #213753;
                    --primary-dark: #1b3a51;
                    --gray: #666666;
                    --light-blue: #e8f2ff;
                    --font-family-serif: 'Crimson Text', serif;
                    min-height: 500px;
                    outline: none;
                    font-size: 1.1rem;
                    line-height: 1.8;
                    color: var(--gray);
                }
                .visual-editor-content h2 {
                    color: var(--primary-color);
                    margin-top: 2rem;
                    margin-bottom: 1.5rem;
                    font-size: 1.8rem;
                    border-bottom: 2px solid var(--light-blue);
                    padding-bottom: 0.5rem;
                    font-family: var(--font-family-serif);
                    font-weight: 400;
                }
                .visual-editor-content h3 {
                    color: var(--primary-dark);
                    margin-top: 2rem;
                    margin-bottom: 1rem;
                    font-size: 1.4rem;
                    font-family: var(--font-family-serif);
                    font-weight: 400;
                }
                .visual-editor-content p {
                    margin-bottom: 1.5rem;
                }
                .visual-editor-content ul {
                    margin: 1.5rem 0;
                    padding-left: 1.5rem;
                    list-style-type: disc;
                }
                .visual-editor-content li {
                    margin-bottom: 0.75rem;
                }
                
                .floating-ui {
                    position: absolute;
                    z-index: 1000;
                    transition: all 0.2s ease;
                }
                
                .format-toolbar {
                    display: flex;
                    gap: 2px;
                    background: #1e293b;
                    padding: 4px;
                    border-radius: 8px;
                    box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1);
                }
                
                .format-toolbar button {
                    color: white;
                    width: 32px;
                    height: 32px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 4px;
                    font-size: 12px;
                    font-weight: bold;
                }
                
                .format-toolbar button:hover {
                    background: #334155;
                    color: #818cf8;
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
                    color: #6366f1;
                }

                .visual-editor-content:empty:before {
                    content: 'Začnite písať...';
                    color: #cbd5e1;
                    pointer-events: none;
                }
            `}} />

            {toolbarPos.visible && (
                <div
                    className="floating-ui"
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
                            <PlusCircleIcon className="w-6 h-6 block-picker" />
                            <div className="hidden group-hover:flex absolute left-8 top-0 format-toolbar">
                                {tools.filter(t => typeof t.icon === 'string' || t.label === 'Odstavec').map((tool, i) => (
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
                className="visual-editor-content bg-white p-12 rounded-2xl min-h-[600px] border border-gray-100"
                placeholder="Sem napíšte obsah článku..."
            />
        </div>
    );
};

export default LegisBlogRichTextEditor;
